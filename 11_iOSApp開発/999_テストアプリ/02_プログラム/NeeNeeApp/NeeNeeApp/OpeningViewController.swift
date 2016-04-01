//
//  OpeningViewController.swift
//  NeeNeeApp
//
//  Created by 石川晃次 on 2015/12/27.
//  Copyright © 2015年 KojiIshikawa. All rights reserved.
//

import UIKit
import Social
import iAd
import AVFoundation


class OpeningViewController: UIViewController, AVAudioPlayerDelegate,UITextFieldDelegate,UIPopoverPresentationControllerDelegate {
    
    
    //****************************************
    // MARK: - メンバ変数
    //****************************************

    // バナー
    private var footerBaner: ADBannerView!
    
    // 壁紙オブジェクト
    private var myImageView: UIImageView!
    private var titleImageView: UIImageView!

    // ラベルオブジェクト
    private var nameLabel: UILabel!
    private var birthLabel: UILabel!
    
    // 入力項目
    // 名前入力
    // 生年月日
    private var nameText: UITextField!
    private var birthDatePicker: UIDatePicker!
    
    // スタートボタン
    private var startBtn: UIButton!
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }
    
    //****************************************
    // MARK: - イベント
    //****************************************
    
    // view ロード完了時
    override func viewDidLoad() {
        print(NSDate().description, __FUNCTION__, __LINE__)
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        print(NSDate().description, __FUNCTION__, __LINE__)
        super.viewDidAppear(animated)
        
        // キャラクター基本情報が存在する場合
        if getCharaBaseExists() {
            
            print("基本情報あり")
            
            // 画面遷移する.
            let NextViewController = self.storyboard!.instantiateViewControllerWithIdentifier( "NeetMain" )
            self.presentViewController( NextViewController, animated: true, completion: nil)
            
        } else {
            
            print("基本情報なし")
            
            // オブジェクトの配置
            self.createObjInit()
            
            // オブジェクトの制約設定
            self.objConstraints()
            
            //NSUserDefaultに音量を初期セット
            let ud = NSUserDefaults.standardUserDefaults()
            ud.setFloat(0.3, forKey: "VOL_SE")
            ud.setFloat(0.3, forKey: "VOL_BGM")
            ud.synchronize()
            
            // BGMを再生する.
            Utility.bgmSoundPlay(Const.myOpeningPath)
        }
    }
        
    override func didReceiveMemoryWarning() {
        print(NSDate().description, __FUNCTION__, __LINE__)
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /** メニューボタン押下時の処理 **/
    func tapStartBtn(sender: AnyObject) {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        // SEを再生する.
        Utility.seSoundPlay(Const.mySeStartPath)
        
        // BGMを止める
        Utility.bgmStop()
        
        // データベースに基本情報を書き込む.
        editCharaBase()
        editInitRJob()
        editGetItem()
        Utility.editT_RefStage(1)
        
        // 画面遷移する.
        let NextViewController = self.storyboard!.instantiateViewControllerWithIdentifier( "NeetMain" )
        self.presentViewController( NextViewController, animated: true, completion: nil)
        
    }

    //****************************************
    // MARK: - その他メソッド
    //****************************************
    
    func getUncachedImage (named name : String) -> UIImage?
    {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        if let imgPath = NSBundle.mainBundle().pathForResource(name, ofType: nil)
        {
            return UIImage(contentsOfFile: imgPath)
        }
        return nil
    }
    
    //初期表示時のオブジェクトを作成し設置する
    func createObjInit() {
        print(NSDate().description, __FUNCTION__, __LINE__)
        // 背景設定
        myImageView = UIImageView(frame: CGRectMake(0,0,self.view.bounds.width,self.view.bounds.height))
        myImageView.image = self.getUncachedImage(named:"03_27_01.png")
        self.view.addSubview(myImageView)

        // ラベル設定
        nameLabel = UILabel()
        nameLabel.text = "　　　なまえ"
        nameLabel.textColor = UIColor.whiteColor()
        nameLabel.font = UIFont(name: "HiraKakuProN-W3", size: 12)
        self.view.addSubview(nameLabel)
        
        birthLabel = UILabel()
        birthLabel.text = "たんじょうび"
        birthLabel.textColor = UIColor.whiteColor()
        birthLabel.font = UIFont(name: "HiraKakuProN-W3", size: 12)
        self.view.addSubview(birthLabel)
        
        // タイトル設定
        titleImageView = UIImageView(frame: CGRectMake(0,0,self.view.bounds.width,self.view.bounds.height))
        titleImageView.image = self.getUncachedImage(named:"08_03_01.png")
        self.view.addSubview(titleImageView)
        
        // フッタのバナーを生成する.
        self.footerBaner = ADBannerView()
        self.footerBaner.frame.offsetInPlace(dx: 0, dy: self.view.bounds.height-footerBaner.frame.height)
        self.footerBaner?.hidden = false
        self.view.addSubview(footerBaner)
        
        // iAd(インタースティシャル)のマニュアル表示設定
        self.interstitialPresentationPolicy = ADInterstitialPresentationPolicy.Manual

        // 名前入力テキストボックスの設定.
        nameText = UITextField()
        nameText.delegate = self
        nameText.borderStyle = UITextBorderStyle.Bezel
        nameText.placeholder = "ニートの名前"
        self.view.addSubview(nameText)
        
        // 生年月日の設定.
        birthDatePicker = UIDatePicker()
        birthDatePicker.datePickerMode = UIDatePickerMode.Date
        birthDatePicker.locale = NSLocale(localeIdentifier: "ja_JP")
        self.view.addSubview(birthDatePicker)

        // スタートボタンの設定.
        startBtn = UIButton()
        startBtn.setImage(Utility.getUncachedImage(named: "01_11_01.png"), forState: .Normal)
        startBtn.addTarget(self, action: "tapStartBtn:", forControlEvents: .TouchUpInside)
        self.view.addSubview(startBtn)
    }
    
    /** 全オブジェクトの制約設定 **/
    func objConstraints() {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameText.translatesAutoresizingMaskIntoConstraints = false
        birthLabel.translatesAutoresizingMaskIntoConstraints = false
        birthDatePicker.translatesAutoresizingMaskIntoConstraints = false
        startBtn.translatesAutoresizingMaskIntoConstraints = false
        
        // タイトルイメージの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.titleImageView,
                attribute:  NSLayoutAttribute.CenterX,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.CenterX,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.titleImageView,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.CenterY,
                multiplier: 1.0,
                constant: -60
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.titleImageView,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0 / 1.6,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.titleImageView,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0 / 6.0,
                constant: 0
            )]
        )
        
        // 名前ラベルの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.nameLabel,
                attribute:  NSLayoutAttribute.Left,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.Left,
                multiplier: 1.0,
                constant: 20
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.nameLabel,
                attribute: NSLayoutAttribute.Top,
                relatedBy: .Equal,
                toItem: self.titleImageView,
                attribute:  NSLayoutAttribute.Bottom,
                multiplier: 1.0,
                constant: 20
            ),
            // 横幅
            NSLayoutConstraint(
                item: self.nameLabel,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0 / 5.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.nameLabel,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0 / 10.0,
                constant: 0
            )]
        )
        
        // 名前テキストボックスの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.nameText,
                attribute:  NSLayoutAttribute.Left,
                relatedBy: .Equal,
                toItem: self.nameLabel,
                attribute:  NSLayoutAttribute.Right,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.nameText,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: .Equal,
                toItem: self.nameLabel,
                attribute:  NSLayoutAttribute.CenterY,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.nameText,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0 / 2.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.nameText,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0 / 12.0,
                constant: 0
            )]
        )
     
        // 誕生日ラベルの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.birthLabel,
                attribute:  NSLayoutAttribute.Left,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.Left,
                multiplier: 1.0,
                constant: 20
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.birthLabel,
                attribute: NSLayoutAttribute.Top,
                relatedBy: .Equal,
                toItem: self.nameLabel,
                attribute:  NSLayoutAttribute.Bottom,
                multiplier: 1.0,
                constant: 20
            ),
            // 横幅
            NSLayoutConstraint(
                item: self.birthLabel,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0 / 5.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.birthLabel,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0 / 10.0,
                constant: 0
            )]
        )
        
        // 誕生日デートピッカーの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.birthDatePicker,
                attribute:  NSLayoutAttribute.Left,
                relatedBy: .Equal,
                toItem: self.nameLabel,
                attribute:  NSLayoutAttribute.Right,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.birthDatePicker,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: .Equal,
                toItem: self.birthLabel,
                attribute:  NSLayoutAttribute.CenterY,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.birthDatePicker,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0/1.6,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.birthDatePicker,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0 / 8.0,
                constant: 0
            )]
        )

        
        // スタートボタンの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.startBtn,
                attribute:  NSLayoutAttribute.Right,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.Right,
                multiplier: 1.0,
                constant: -20
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.startBtn,
                attribute: NSLayoutAttribute.Bottom,
                relatedBy: .Equal,
                toItem: self.footerBaner,
                attribute:  NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: -20
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.startBtn,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0 / 4.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.startBtn,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0 / 12.0,
                constant: 0
            )]
        )
        
      }
    
    
    //****************************************
    // MARK: - TextField Delegate
    //****************************************
    /*
    UITextFieldが編集された直後に呼ばれるデリゲートメソッド.
    */
    func textFieldDidBeginEditing(textField: UITextField){
        print("textFieldDidBeginEditing:" + textField.text!)
    }
    
    /*
    UITextFieldが編集終了する直前に呼ばれるデリゲートメソッド.
    */
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        print("textFieldShouldEndEditing:" + textField.text!)
        
        return true
    }
    
    /*
    改行ボタンが押された際に呼ばれるデリゲートメソッド.
    */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    
    //****************************************
    // MARK: - DB Access
    //****************************************
    
    //キャラクター情報の取得
    func getCharaBaseExists() -> DarwinBoolean  {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        // キャラクター基本情報にアクセスし存在しなければfalseを返却する.
        let charaBaseList :[T_CharaBase] = T_CharaBase.MR_findAll() as! [T_CharaBase];
        print(charaBaseList.count)
        return  charaBaseList.count == 0 ? false : true
    }
    
    //キャラクター情報の書き込み
    func editCharaBase() -> DarwinBoolean  {
        print(NSDate().description, __FUNCTION__, __LINE__)

        // キャラクター基本情報に基本情報を書き込む
        let insetData = T_CharaBase.MR_createEntity()! as T_CharaBase
        insetData.charaID = Const.CHARACTER1_ID
        insetData.charaName = nameText.text
        insetData.charaBirth = birthDatePicker.date
        insetData.managedObjectContext!.MR_saveToPersistentStoreAndWait()

        print(insetData.charaName)
        print(insetData.charaBirth)

        return true
    }
    
    //役職の初期設定
    func editInitRJob() -> DarwinBoolean  {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        // 現在の役職に最小値をセットする.
        let insetData = T_RefJob.MR_createEntity()! as T_RefJob
        insetData.charaID = Const.CHARACTER1_ID
        insetData.jobID = 1
        insetData.managedObjectContext!.MR_saveToPersistentStoreAndWait()
        
        print(insetData.charaID)
        print(insetData.jobID)
        
        return true
    }
    
    //初期所持アイテムの書き込み
    func editGetItem() -> DarwinBoolean  {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        // アイテム１を追加
        let initItem1 = T_GetItem.MR_createEntity()! as T_GetItem
        initItem1.charaID = Const.CHARACTER1_ID
        initItem1.itemCount = 10
        initItem1.itemID = 1
        initItem1.managedObjectContext!.MR_saveToPersistentStoreAndWait()

        // アイテム２を追加
        let initItem2 = T_GetItem.MR_createEntity()! as T_GetItem
        initItem2.charaID = Const.CHARACTER1_ID
        initItem2.itemCount = 10
        initItem2.itemID = 4
        initItem2.managedObjectContext!.MR_saveToPersistentStoreAndWait()

        // アイテム３を追加
        let initItem3 = T_GetItem.MR_createEntity()! as T_GetItem
        initItem3.charaID = Const.CHARACTER1_ID
        initItem3.itemCount = 10
        initItem3.itemID = 10
        initItem3.managedObjectContext!.MR_saveToPersistentStoreAndWait()
        
        // アイテム４を追加
        let initItem4 = T_GetItem.MR_createEntity()! as T_GetItem
        initItem4.charaID = Const.CHARACTER1_ID
        initItem4.itemCount = 10
        initItem4.itemID = 11
        initItem4.managedObjectContext!.MR_saveToPersistentStoreAndWait()
        
        // アイテム５を追加
        let initItem5 = T_GetItem.MR_createEntity()! as T_GetItem
        initItem5.charaID = Const.CHARACTER1_ID
        initItem5.itemCount = 10
        initItem5.itemID = 12
        initItem5.managedObjectContext!.MR_saveToPersistentStoreAndWait()
        
        return true
    }
}

