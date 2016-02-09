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
    
    // BGM・SEの再生用オブジェクト
    private var myAudioPlayer: AVAudioPlayer!
    private var mySePlayer: AVAudioPlayer!
    
    // バナー
    private var footerBaner: ADBannerView!
    
    // 壁紙オブジェクト
    private var myImageView: UIImageView!

    // 名前入力テキスト
    private var nameText: UITextField!
    
    // 生年月日
    private var birthDatePicker: UIDatePicker!
    
    // スタートボタン
    private var startBtn: UIButton!
    
    // 定数宣言
    private let mySongPath = NSBundle.mainBundle().pathForResource("start data config", ofType:"mp3")
    private let mySeStartPath = NSBundle.mainBundle().pathForResource("se5", ofType:"mp3")
    
    // メニューボタンの画像設定
    private let startBtnImage = UIImage(named: "01_11_01.png")
    
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
        
        // キャラクター基本情報が存在する場合
        if getCharaBaseExists() {
            
            // 画面遷移する.
            let NextViewController = self.storyboard!.instantiateViewControllerWithIdentifier( "NeetMain" )
            self.presentViewController( NextViewController, animated: true, completion: nil)

        } else {

            // オブジェクトの配置
            self.createObjInit()
            
            // オブジェクトの制約設定
            self.objConstraints()

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
        seSoundPlay(mySeStartPath!)
        
        // BGMを止める
        myAudioPlayer.stop()
        
        // データベースに基本情報を書き込む.
        editCharaBase()
        
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
        
        // 背景設定
        myImageView = UIImageView(frame: CGRectMake(0,0,self.view.bounds.width,self.view.bounds.height))
        myImageView.image = self.getUncachedImage(named:"03_27_01.png")
        self.view.addSubview(myImageView)
        
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
        self.view.addSubview(birthDatePicker)

        // スタートボタンの設定.
        startBtn = UIButton()
        startBtn.setImage(startBtnImage, forState: .Normal)
        startBtn.addTarget(self, action: "tapStartBtn:", forControlEvents: .TouchUpInside)
        self.view.addSubview(startBtn)
        
        // テーマソングを再生する.
        do {
            myAudioPlayer = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath:mySongPath!))
            myAudioPlayer.numberOfLoops = -1
            myAudioPlayer.play()
            
        }catch{
            // 例外発生
        }
    }
    
    /** 全オブジェクトの制約設定 **/
    func objConstraints() {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        nameText.translatesAutoresizingMaskIntoConstraints = false
        birthDatePicker.translatesAutoresizingMaskIntoConstraints = false
        startBtn.translatesAutoresizingMaskIntoConstraints = false
        
        // 名前テキストボックスの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.nameText,
                attribute:  NSLayoutAttribute.CenterX,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.CenterX,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.nameText,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.CenterY,
                multiplier: 1.0,
                constant: 60
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.nameText,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0 / 2,
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
        
        // 生年月日の制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.birthDatePicker,
                attribute:  NSLayoutAttribute.CenterX,
                relatedBy: .Equal,
                toItem: self.nameText,
                attribute:  NSLayoutAttribute.CenterX,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.birthDatePicker,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: .Equal,
                toItem: self.nameText,
                attribute:  NSLayoutAttribute.Bottom,
                multiplier: 1.0,
                constant: 20
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.birthDatePicker,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0,
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
    
    /** SE再生 **/
    func seSoundPlay(sePath: String)
    {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        // SEを再生する.
        do {
            mySePlayer = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath:sePath))
            mySePlayer.volume = 5.0
            mySePlayer.play()
            
        }catch{
            // 例外発生
        }
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
        
        // TODO:トランザクションテーブルにアクセス可能になれば実装可能
        return false
    }
    
    //キャラクター情報の書き込み
    func editCharaBase() -> DarwinBoolean  {
        print(NSDate().description, __FUNCTION__, __LINE__)

        // TODO:トランザクションテーブルにアクセス可能になれば実装可能
        return false
    }
}

