//
//  OpeningViewController.swift
//  NeeNeeApp
//
//  Created by Boil Project on 2015/12/27.
//  Copyright © 2015年 Boil Project. All rights reserved.
//

import UIKit
import Social
import AVFoundation
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}



class OpeningViewController: UIViewController, AVAudioPlayerDelegate,UITextFieldDelegate,UIPopoverPresentationControllerDelegate {
    
    
    //****************************************
    // MARK: - メンバ変数
    //****************************************
    
    // 壁紙オブジェクト
    fileprivate var myImageView: UIImageView!
    fileprivate var titleImageView: UIImageView!

    // ラベルオブジェクト
    fileprivate var projectLabel: UILabel!
    fileprivate var nameLabel: UILabel!
    fileprivate var birthLabel: UILabel!
    
    // 入力項目
    // 名前入力
    // 生年月日
    fileprivate var nameText: UITextField!
    fileprivate var birthDatePicker: UIDatePicker!
    
    // スタートボタン
    fileprivate var startBtn: UIButton!
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }
    
    //****************************************
    // MARK: - イベント
    //****************************************
    
    // view ロード完了時
    override func viewDidLoad() {
        print(Date().description, NSStringFromClass(self.classForCoder), #function,#line)
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(Date().description, NSStringFromClass(self.classForCoder), #function,#line)
        super.viewDidAppear(animated)
        
        // キャラクター基本情報が存在する場合
        if getCharaBaseExists().boolValue {
            
            print("基本情報あり")
            
            // 画面遷移する.
            let NextViewController = self.storyboard!.instantiateViewController( withIdentifier: "NeetMain" )
            self.present( NextViewController, animated: true, completion: nil)
            
        } else {
            
            print("基本情報なし")
            
            // オブジェクトの配置
            self.createObjInit()
            
            // オブジェクトの制約設定
            self.objConstraints()
            
            //NSUserDefaultに音量を初期セット
            let ud = UserDefaults.standard
            ud.set(0.3, forKey: "VOL_SE")
            ud.set(0.3, forKey: "VOL_BGM")
            ud.synchronize()
            
            // BGMを再生する.
            Utility.bgmSoundPlay(Const.BGM_OPENING_PATH)
        }
    }
        
    override func didReceiveMemoryWarning() {
        print(Date().description, NSStringFromClass(self.classForCoder), #function,#line)
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /** メニューボタン押下時の処理 **/
    func tapStartBtn(_ sender: AnyObject) {
        print(Date().description, NSStringFromClass(self.classForCoder), #function,#line)
        
        // なまえの文字列長エラー
        if nameText.text?.characters.count < 1 || nameText.text?.characters.count > 8 {

            // SEを再生する.
            Utility.seSoundPlay(Const.SE_NO_PATH)
            
            let alertController = UIAlertController(title: "なまえが不正", message: "「なまえ」は1文字以上8文字以内にしてね", preferredStyle: .alert)
            
            let defaultActionYes = UIAlertAction(title: "はい", style: .default, handler:{
                (action:UIAlertAction!) -> Void in

            })
            
            alertController.addAction(defaultActionYes)
            present(alertController, animated: true, completion: nil)

            return;
        }

        // SEを再生する.
        Utility.seSoundPlay(Const.SE_START_PATH)
        
        // BGMを止める
        Utility.bgmStop()
        
        // データベースに基本情報を書き込む.
        _ = editCharaBase()
        _ = editInitRJob()
        _ = editGetItem()
        Utility.editT_RefStage(1)
        
        // 画面遷移する.
        let NextViewController = self.storyboard!.instantiateViewController( withIdentifier: "StoryView" )
        self.present( NextViewController, animated: true, completion: nil)
        
    }

    //****************************************
    // MARK: - その他メソッド
    //****************************************
    
    //初期表示時のオブジェクトを作成し設置する
    func createObjInit() {
        print(Date().description, NSStringFromClass(self.classForCoder), #function,#line)
        // 背景設定
        myImageView = UIImageView(frame: CGRect(x: 0,y: 0,width: self.view.bounds.width,height: self.view.bounds.height))
        myImageView.image = Utility.getUncachedImage(named:"03_27_01.png")
        self.view.addSubview(myImageView)

        // ラベル設定
        projectLabel = UILabel()
        projectLabel.text = "2016 Boil Project."
        projectLabel.textColor = UIColor.white
        projectLabel.font = UIFont.systemFont(ofSize: Utility.getMojiSize(Const.SIZEKBN_LARGE))
        self.view.addSubview(projectLabel)
        
        nameLabel = UILabel()
        nameLabel.text = "　　　なまえ"
        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont.systemFont(ofSize: Utility.getMojiSize(Const.SIZEKBN_MIDDLE))
        self.view.addSubview(nameLabel)
        
        birthLabel = UILabel()
        birthLabel.numberOfLines = 0
        birthLabel.text = "　　　たんじ\n　　　ょうび"
        birthLabel.textColor = UIColor.white
        birthLabel.font = UIFont.systemFont(ofSize: Utility.getMojiSize(Const.SIZEKBN_MIDDLE))
        self.view.addSubview(birthLabel)
        
        // タイトル設定
        titleImageView = UIImageView(frame: CGRect(x: 0,y: 0,width: self.view.bounds.width,height: self.view.bounds.height))
        titleImageView.image = Utility.getUncachedImage(named:"08_03_01.png")
        self.view.addSubview(titleImageView)

        // 名前入力テキストボックスの設定.
        nameText = UITextField()
        nameText.delegate = self
        nameText.borderStyle = UITextBorderStyle.bezel
        nameText.placeholder = "8文字以内"
        nameText.textColor = UIColor.white
        self.view.addSubview(nameText)
        
        // 生年月日の設定.
        birthDatePicker = UIDatePicker()
        birthDatePicker.datePickerMode = UIDatePickerMode.date
        birthDatePicker.locale = Locale(identifier: "ja_JP")
        self.view.addSubview(birthDatePicker)

        // スタートボタンの設定.
        startBtn = UIButton()
        startBtn.setImage(Utility.getUncachedImage(named: "01_11_01.png"), for: UIControlState())
        startBtn.addTarget(self, action: #selector(OpeningViewController.tapStartBtn(_:)), for: .touchUpInside)
        self.view.addSubview(startBtn)
    }
    
    /** 全オブジェクトの制約設定 **/
    func objConstraints() {
        print(Date().description, NSStringFromClass(self.classForCoder), #function,#line)
        
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        projectLabel.translatesAutoresizingMaskIntoConstraints = false
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
                attribute:  NSLayoutAttribute.centerX,
                relatedBy: .equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.centerX,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.titleImageView,
                attribute: NSLayoutAttribute.centerY,
                relatedBy: .equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.centerY,
                multiplier: 1.0 / 1.4,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.titleImageView,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .width,
                multiplier: 1.0 / 1.6,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.titleImageView,
                attribute: .height,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .height,
                multiplier: 1.0 / 6.0,
                constant: 0
            )]
        )
        
        // プロジェクトラベルの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.projectLabel,
                attribute:  NSLayoutAttribute.centerX,
                relatedBy: .equal,
                toItem: self.titleImageView,
                attribute:  NSLayoutAttribute.centerX,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.projectLabel,
                attribute: NSLayoutAttribute.top,
                relatedBy: .equal,
                toItem: self.titleImageView,
                attribute:  NSLayoutAttribute.bottom,
                multiplier: 0.9 / 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.projectLabel,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .width,
                multiplier: 1.8 / 4.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.projectLabel,
                attribute: .height,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .height,
                multiplier: 1.0 / 10.0,
                constant: 0
            )]
        )
        
        // 名前ラベルの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.nameLabel,
                attribute:  NSLayoutAttribute.left,
                relatedBy: .equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.left,
                multiplier: 1.0 / 1.2,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.nameLabel,
                attribute: NSLayoutAttribute.top,
                relatedBy: .equal,
                toItem: self.titleImageView,
                attribute:  NSLayoutAttribute.bottom,
                multiplier: 1.2 / 1.0,
                constant: 0
            ),
            // 横幅
            NSLayoutConstraint(
                item: self.nameLabel,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .width,
                multiplier: 1.0 / 4.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.nameLabel,
                attribute: .height,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .height,
                multiplier: 1.0 / 10.0,
                constant: 0
            )]
        )
        
        // 名前テキストボックスの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.nameText,
                attribute:  NSLayoutAttribute.left,
                relatedBy: .equal,
                toItem: self.nameLabel,
                attribute:  NSLayoutAttribute.right,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.nameText,
                attribute: NSLayoutAttribute.centerY,
                relatedBy: .equal,
                toItem: self.nameLabel,
                attribute:  NSLayoutAttribute.centerY,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.nameText,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .width,
                multiplier: 1.0 / 2.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.nameText,
                attribute: .height,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .height,
                multiplier: 1.0 / 12.0,
                constant: 0
            )]
        )
     
        // 誕生日ラベルの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.birthLabel,
                attribute:  NSLayoutAttribute.left,
                relatedBy: .equal,
                toItem: self.nameLabel,
                attribute:  NSLayoutAttribute.left,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.birthLabel,
                attribute: NSLayoutAttribute.top,
                relatedBy: .equal,
                toItem: self.nameLabel,
                attribute:  NSLayoutAttribute.bottom,
                multiplier: 1.02 / 1.0,
                constant: 0
            ),
            // 横幅
            NSLayoutConstraint(
                item: self.birthLabel,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .width,
                multiplier: 1.0 / 4.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.birthLabel,
                attribute: .height,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .height,
                multiplier: 1.0 / 8.0,
                constant: 0
            )]
        )
        
        // 誕生日デートピッカーの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.birthDatePicker,
                attribute:  NSLayoutAttribute.left,
                relatedBy: .equal,
                toItem: self.nameLabel,
                attribute:  NSLayoutAttribute.right,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.birthDatePicker,
                attribute: NSLayoutAttribute.centerY,
                relatedBy: .equal,
                toItem: self.birthLabel,
                attribute:  NSLayoutAttribute.centerY,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.birthDatePicker,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .width,
                multiplier: 1.0 / 1.4,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.birthDatePicker,
                attribute: .height,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .height,
                multiplier: 1.0 / 8.0,
                constant: 0
            )]
        )
        
        // スタートボタンの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.startBtn,
                attribute:  NSLayoutAttribute.right,
                relatedBy: .equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.right,
                multiplier: 1.0 / 1.05,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.startBtn,
                attribute: NSLayoutAttribute.bottom,
                relatedBy: .equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.bottom,
                multiplier: 1.0 / 1.02,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.startBtn,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .width,
                multiplier: 1.0 / 4.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.startBtn,
                attribute: .height,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .height,
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
    func textFieldDidBeginEditing(_ textField: UITextField){
        print("textFieldDidBeginEditing:" + textField.text!)
    }
    
    /*
    UITextFieldが編集終了する直前に呼ばれるデリゲートメソッド.
    */
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldEndEditing:" + textField.text!)
        
        return true
    }
    
    /*
    改行ボタンが押された際に呼ばれるデリゲートメソッド.
    */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    
    //****************************************
    // MARK: - DB Access
    //****************************************
    
    //キャラクター情報の取得
    func getCharaBaseExists() -> DarwinBoolean  {
        print(Date().description, NSStringFromClass(self.classForCoder), #function,#line)
        
        // キャラクター基本情報にアクセスし存在しなければfalseを返却する.
        let charaBaseList :[T_CharaBase] = T_CharaBase.mr_findAll() as! [T_CharaBase];
        print(charaBaseList.count)
        return  charaBaseList.count == 0 ? false : true
    }
    
    //キャラクター情報の書き込み
    func editCharaBase() -> DarwinBoolean  {
        print(Date().description, NSStringFromClass(self.classForCoder), #function,#line)

        // キャラクター基本情報に基本情報を書き込む
        let insetData = T_CharaBase.mr_createEntity()! as T_CharaBase
        insetData.charaID = Const.CHARACTER1_ID as NSNumber!
        insetData.charaName = nameText.text
        insetData.charaBirth = birthDatePicker.date
        insetData.managedObjectContext!.mr_saveToPersistentStoreAndWait()

        print(insetData.charaName)
        print(insetData.charaBirth)

        return true
    }
    
    //役職の初期設定
    func editInitRJob() -> DarwinBoolean  {
        print(Date().description, NSStringFromClass(self.classForCoder), #function,#line)
        
        // 現在の役職に最小値をセットする.
        let insetData = T_RefJob.mr_createEntity()! as T_RefJob
        insetData.charaID = Const.CHARACTER1_ID as NSNumber!
        insetData.jobID = 1
        insetData.managedObjectContext!.mr_saveToPersistentStoreAndWait()
        
        print(insetData.charaID)
        print(insetData.jobID)
        
        return true
    }
    
    //初期所持アイテムの書き込み
    func editGetItem() -> DarwinBoolean  {
        print(Date().description, NSStringFromClass(self.classForCoder), #function,#line)
        

        for i in 1 ..< 51 {

            // アイテム１を追加
            let initItem1 = T_GetItem.mr_createEntity()! as T_GetItem
            initItem1.charaID = Const.CHARACTER1_ID as NSNumber!
            initItem1.itemCount = 10
            initItem1.itemID = i as NSNumber!
            initItem1.managedObjectContext!.mr_saveToPersistentStoreAndWait()
        }

        /**
        // アイテム１を追加
        let initItem1 = T_GetItem.mr_createEntity()! as T_GetItem
        initItem1.charaID = Const.CHARACTER1_ID as NSNumber!
        initItem1.itemCount = 3
        initItem1.itemID = 1
        initItem1.managedObjectContext!.mr_saveToPersistentStoreAndWait()
        **/
        
        return true
    }
}

