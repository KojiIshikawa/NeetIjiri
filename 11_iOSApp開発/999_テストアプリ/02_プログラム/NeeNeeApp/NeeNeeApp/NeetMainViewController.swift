//
//  NeetMainViewController.swift
//  NeeNeeApp
//
//  Created by 石川晃次 on 2015/12/27.
//  Copyright © 2015年 KojiIshikawa. All rights reserved.
//

import UIKit
import iAd
import AVFoundation


class NeetMainViewController: UIViewController, AVAudioPlayerDelegate,UICollectionViewDelegate,
                                UIGestureRecognizerDelegate,UIPopoverPresentationControllerDelegate {

    
    //****************************************
    // MARK: - メンバ変数
    //****************************************

    // BGM・SEの再生用オブジェクト
    private var myAudioPlayer: AVAudioPlayer!
    private var mySePlayer: AVAudioPlayer!
    
    // バナー
    private var footerBaner: ADBannerView!
    
    // メニューボタン制御用
    private var manuBtnFlg = true
    
    // 壁紙オブジェクト
    private var myImageView: UIImageView!
    
    // キャラクターオブジェクト
    private var myCharImageView: UIImageView!
    private var myFukidasiImageView: UIImageView!
    private var fukidasiLabel: UILabel!

    // メニューボタン
    private var manuBtn: UIButton!
    private var mainBtn: UIButton!
    private var shareBtn: UIButton!
    private var detailBtn: UIButton!
    private var configBtn: UIButton!
    
    // メニューのサブビュー
//    private var detailConView: UIView!
//    private var shareConView: UIView!
//    private var configConView: UIView!
    
    // メインの背景画像用オブジェクト
    private var mainImgView: UIImageView!
    private var mainImgSubView: UIImageView!
//    private var detailImgView: UIImageView!
//    private var detailImgSubView: UIImageView!
//    private var shareImgView: UIImageView!
//    private var configImgView: UIImageView!

    // 履歴書メニューのオブジェクト
    private var nameDataLabel: UILabel!
    private var birthDataLabel: UILabel!
    private var positionDataLabel: UILabel!
    private var compDataLabel: UILabel!
    private var kakugenDataLabel: UILabel!
    
//    // シェアメニューのオブジェクト
//    private var facebookBtn: UIButton!
//    private var lineBtn: UIButton!
//    private var twitterBtn: UIButton!
    
//    // 設定メニューのオブジェクト
//    private var bgmMuteBtn: UIButton!
//    private var bgmVolumeSBar: UISlider!
//    private var bgmLabel: UILabel!
//    private var seMuteBtn: UIButton!
//    private var seVolumeSBar: UISlider!
//    private var seLabel: UILabel!
    
    // 定数宣言
    private let mySongPath = NSBundle.mainBundle().pathForResource("暇で忙しい", ofType:"mp3")
    internal let mySeYesPath = NSBundle.mainBundle().pathForResource("se4", ofType:"mp3")
    private let mySeNoPath = NSBundle.mainBundle().pathForResource("se6", ofType:"mp3")

    //TODO:メモリ使用量削減のため、極力必要な時に、宣言、解放すること
    private let myImage = UIImage(named: "03_01_01")
    private let fukidasiImage = UIImage( named: "05_01_01")!

    
    // メニュー画面の画像設定
    private let mainViewImage = UIImage(named: "02_01_01.png")
    private let mainViewSubImage = UIImage(named: "02_05_01.png")
//    private let detailViewImage = UIImage(named: "02_02_01.png")
//    private let detailViewSubImage = UIImage(named: "02_06_01.png")
//    private let shareViewImage = UIImage(named: "02_03_01.png")
//    private let configViewImage = UIImage(named: "02_04_01.png")

    // メニューボタンの画像設定
    private let manuBtnNextImage = UIImage(named: "01_01_01.png")
    private let manuBtnBackActImage = UIImage(named: "01_02_01.png")
    private let manuBtnBackInActImage = UIImage(named: "01_02_02.png")
    private let mainBtnActImage = UIImage(named: "01_03_01.png")
    private let mainBtnInActImage = UIImage(named: "01_03_02.png")
    private let detailBtnActImage = UIImage(named: "01_04_01.png")
    private let detailBtnInActImage = UIImage(named: "01_04_02.png")
    private let shareBtnActImage = UIImage(named: "01_05_01.png")
    private let shareBtnInActImage = UIImage(named: "01_05_02.png")
    private let configBtnActImage = UIImage(named: "01_06_01.png")
    private let configBtnInActImage = UIImage(named: "01_06_02.png")

    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }
    
    //アニメーションタイマー
    private var animeTimer: NSTimer!
    

    //****************************************
    // MARK: - イベント
    //****************************************
    
    
    
    // view ロード完了時
    override func viewDidLoad() {
        print(NSDate().description, __FUNCTION__, __LINE__)
        super.viewDidLoad()
        
        //オブジェクトの配置
        self.createObjInit()
        
//        // 履歴書メニューの生成
//        self.detailInit()
        
//        // シェアメニューの生成
//        self.shareInit()
        
        // 設定メニューの生成
        self.configInit()
        
        // オブジェクトの制約の設定
        self.objConstraints()
        
        //アニメーション開始
        self.animationStart()
        
    }
    
    //メモリ消費が多くなった時に動くイベント
    override func didReceiveMemoryWarning() {
        print(NSDate().description, __FUNCTION__, __LINE__)
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /** メニューボタン押下時の処理 **/
    func tapManuBtn(sender: AnyObject) {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        if  manuBtnFlg {
            
            // ボタンの文言を変える
            manuBtn.setImage(manuBtnBackActImage,  forState: .Normal)
            manuBtnFlg = false
            
            // メニュー内ボタンの制御を切り替える.
            mainBtn.hidden = false
            detailBtn.hidden = false
            shareBtn.hidden = false
            configBtn.hidden = false

            // SEを再生する.
            Utility.seSoundPlay(mySeYesPath!)
            
        } else {
            
            // ボタンの文言を変える
            manuBtn.setImage(manuBtnNextImage,  forState: .Normal)
            manuBtnFlg = true
            
            // メニュー内ボタンの制御を切り替える.
            mainBtn.hidden = true
            detailBtn.hidden = true
            shareBtn.hidden = true
            configBtn.hidden = true
            
            // SEを再生する.
            Utility.seSoundPlay(mySeNoPath!)
        
        }
    }
    
    
    //POPOVER実装時に必要になるイベント　おまじない
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController)
        -> UIModalPresentationStyle {
            return .None
    }

    
    
    func showPopoverView(sender: AnyObject, identifier:String) {
        let popoverView = self.storyboard!.instantiateViewControllerWithIdentifier(identifier) as UIViewController
        popoverView.modalPresentationStyle = .Popover

        //TODO:端末種類に依存しないサイズ指定を！
        popoverView.preferredContentSize = CGSizeMake(self.view.bounds.width - 20, self.view.bounds.height - 20)
        
        //TODO:独自のpopoverBackGroundViewを作成し追加すれば、吹き出しのデザインも変えられる
        popoverView.view.backgroundColor = UIColor.clearColor()
        if let presentationController = popoverView.popoverPresentationController {
            presentationController.permittedArrowDirections = .Down
            presentationController.sourceView = sender as! UIButton
            presentationController.sourceRect = sender.bounds
            presentationController.delegate = self
            presentationController.popoverBackgroundViewClass = PopoverBackgroundView.classForCoder()
        }
        self.presentViewController(popoverView, animated: true, completion: nil)
    
    }
    
    
    
    /** ひまつぶしボタン押下時の処理 **/
    func tapMainBtn(sender: AnyObject) {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        // SEを再生する.
        Utility.seSoundPlay(mySeYesPath!)
        
        //PopOverを表示
        self.showPopoverView(sender, identifier: "ActionSetView")
        
    }

    //詳細ボタン押下時
    func tapDetailBtn(sender: AnyObject) {
        print(NSDate().description, __FUNCTION__, __LINE__)

        // SEを再生する.
        Utility.seSoundPlay(mySeYesPath!)
        
        //PopOverを表示
        self.showPopoverView(sender, identifier: "ProfileView")

        
        
//        // ポップの表示・非表示を切り替える.
//        detailConView.hidden = detailConView.hidden ? false:true
        
//        // その他メニューボタンの制御を切り替える.
//        manuBtn.userInteractionEnabled = detailConView.hidden ? true:false
//        mainBtn.userInteractionEnabled = detailConView.hidden ? true:false
//        shareBtn.userInteractionEnabled = detailConView.hidden ? true:false
//        configBtn.userInteractionEnabled = detailConView.hidden ? true:false
//        
//        // ポップが非表示の場合
//        if detailConView.hidden {
//            
//            // 全てのボタンを活性に変更
//            manuBtn.setImage(manuBtnBackActImage, forState: .Normal)
//            mainBtn.setImage(mainBtnActImage, forState: .Normal)
//            detailBtn.setImage(detailBtnActImage, forState: .Normal)
//            shareBtn.setImage(shareBtnActImage, forState: .Normal)
//            configBtn.setImage(configBtnActImage, forState: .Normal)
//            
//            
//            // ポップが表示された場合
//        } else {
//            
//            // 該当メニューのボタン以外を非活性に変更
//            manuBtn.setImage(manuBtnBackInActImage, forState: .Normal)
//            mainBtn.setImage(mainBtnInActImage, forState: .Normal)
//            //detailBtn.setImage(detailBtnInActImage, forState: .Normal)
//            shareBtn.setImage(shareBtnInActImage, forState: .Normal)
//            configBtn.setImage(configBtnInActImage, forState: .Normal)
//            
//        }
    }
    
    /** シェアボタン押下時の処理 **/
    func tapShareBtn(sender: AnyObject) {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        // SEを再生する.
        Utility.seSoundPlay(mySeYesPath!)
        
        //PopOverを表示
        self.showPopoverView(sender, identifier: "SnsView")
        

        
//        // ポップの表示・非表示を切り替える.
//        shareConView.hidden = shareConView.hidden ? false:true
//
//        // その他メニューボタンの制御を切り替える.
//        manuBtn.userInteractionEnabled = shareConView.hidden ? true:false
//        mainBtn.userInteractionEnabled = shareConView.hidden ? true:false
//        detailBtn.userInteractionEnabled = shareConView.hidden ? true:false
//        configBtn.userInteractionEnabled = shareConView.hidden ? true:false
//        
//        // ポップが非表示の場合
//        if shareConView.hidden {
//            
//            // 全てのボタンを活性に変更
//            manuBtn.setImage(manuBtnBackActImage, forState: .Normal)
//            mainBtn.setImage(mainBtnActImage, forState: .Normal)
//            detailBtn.setImage(detailBtnActImage, forState: .Normal)
//            shareBtn.setImage(shareBtnActImage, forState: .Normal)
//            configBtn.setImage(configBtnActImage, forState: .Normal)
//            
//            
//            // ポップが表示された場合
//        } else {
//            
//            // 該当メニューのボタン以外を非活性に変更
//            manuBtn.setImage(manuBtnBackInActImage, forState: .Normal)
//            mainBtn.setImage(mainBtnInActImage, forState: .Normal)
//            detailBtn.setImage(detailBtnInActImage, forState: .Normal)
//            //shareBtn.setImage(shareBtnInActImage, forState: .Normal)
//            configBtn.setImage(configBtnInActImage, forState: .Normal)
//            
//        }
        
    }

    /** 設定ボタン押下時の処理 **/
    func tapConfigBtn(sender: AnyObject) {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        // SEを再生する.
        Utility.seSoundPlay(mySeYesPath!)
        
        //PopOverを表示
        self.showPopoverView(sender, identifier: "SettingView")
        

//        
//        // オブジェクトの表示・非表示を切り替える.
//        configConView.hidden = configConView.hidden ? false:true
//        
//        // その他メニューボタンの制御を切り替える.
//        manuBtn.userInteractionEnabled = configConView.hidden ? true:false
//        mainBtn.userInteractionEnabled = configConView.hidden ? true:false
//        detailBtn.userInteractionEnabled = configConView.hidden ? true:false
//        shareBtn.userInteractionEnabled = configConView.hidden ? true:false
//        
//        // ポップが非表示の場合
//        if configConView.hidden {
//            
//            // 全てのボタンを活性に変更
//            manuBtn.setImage(manuBtnBackActImage, forState: .Normal)
//            mainBtn.setImage(mainBtnActImage, forState: .Normal)
//            detailBtn.setImage(detailBtnActImage, forState: .Normal)
//            shareBtn.setImage(shareBtnActImage, forState: .Normal)
//            configBtn.setImage(configBtnActImage, forState: .Normal)
//            
//            
//            // ポップが表示された場合
//        } else {
//            
//            // 該当メニューのボタン以外を非活性に変更
//            manuBtn.setImage(manuBtnBackInActImage, forState: .Normal)
//            mainBtn.setImage(mainBtnInActImage, forState: .Normal)
//            detailBtn.setImage(detailBtnInActImage, forState: .Normal)
//            shareBtn.setImage(shareBtnInActImage, forState: .Normal)
//            //configBtn.setImage(configBtnInActImage, forState: .Normal)
//            
//        }
    }
    

    
    
    
    // 画面にタッチで呼ばれる
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        // タッチイベントを取得
        let touchEvent = touches.first!

        print(touchEvent.view?.tag.description)
        
        // キャラクター画像がタップされた場合かつ、メニューが非表示の場合
        if touchEvent.view?.tag == 1
//        && detailConView.hidden == true
//        && shareConView.hidden == true
//        && configConView.hidden == true
        {
//            if self.myFukidasiImageView.hidden
//            {
                // ダイアログを表示
                let alertController = UIAlertController(title: "ニートの格言入手", message: "チラシを表示して、今日のニートの格言を取得しますか？", preferredStyle: .Alert)
                
                let defaultActionYes = UIAlertAction(title: "表示する", style: .Default, handler:{
                    (action:UIAlertAction!) -> Void in
                    
                    // iAd(インタースティシャル)の表示
                    self.requestInterstitialAdPresentation()
                    
                    // 吹き出しの表示
                    self.myFukidasiImageView.hidden = false
                    self.fukidasiLabel.text = self.getMeigen()
                    
                })
                
                let defaultActionNo = UIAlertAction(title: "表示しない", style: .Default, handler: nil)
                alertController.addAction(defaultActionYes)
                alertController.addAction(defaultActionNo)
                
                presentViewController(alertController, animated: true, completion: nil)
            
//            } else {
//                self.myFukidasiImageView.hidden = true
//            }
            
        }
        
        
    }
    
    //****************************************
    // MARK: - その他メソッド
    //****************************************

    //初期表示時のオブジェクトを作成し設置する
    func createObjInit() {
        
        // 背景設定
        myImageView = UIImageView(frame: CGRectMake(0,0,self.view.bounds.width,self.view.bounds.height))
        myImageView.image = Utility.getUncachedImage(named: "03_01_01.png")
        self.view.addSubview(myImageView)
        
        //キャラクター設定
        myCharImageView = UIImageView(frame: CGRectMake(150,300,300,350))
        myCharImageView.center.x = self.view.center.x
        myCharImageView.center.y = self.view.center.y
        myCharImageView.tag = 1
        myCharImageView.userInteractionEnabled = true
        self.view.addSubview(myCharImageView)
        
        
        // 吹き出しを生成する.
        myFukidasiImageView = UIImageView(frame: CGRectMake(0,0,200,100))
        myFukidasiImageView.frame.origin.x = myCharImageView.frame.origin.x
        myFukidasiImageView.frame.origin.y = myCharImageView.frame.origin.y - 300
        myFukidasiImageView.image = fukidasiImage
        myFukidasiImageView.hidden = true

        // 吹き出しのラベルを設定する.
        fukidasiLabel = UILabel()
        fukidasiLabel.frame = myFukidasiImageView.bounds
        fukidasiLabel.textAlignment = NSTextAlignment.Center


        // UIImageViewをViewに追加する.
        myCharImageView.addSubview(myFukidasiImageView)
        myFukidasiImageView.addSubview(fukidasiLabel)
        
        
        // フッタのバナーを生成する.
        self.footerBaner = ADBannerView()
        self.footerBaner.frame.offsetInPlace(dx: 0, dy: self.view.bounds.height-footerBaner.frame.height)
        self.footerBaner?.hidden = false
        self.view.addSubview(footerBaner)
        
        // iAd(インタースティシャル)のマニュアル表示設定
        self.interstitialPresentationPolicy = ADInterstitialPresentationPolicy.Manual
        
        // メニューボタン及びサブメニューボタンの設定.
        manuBtn = UIButton(frame: CGRectMake(self.view.bounds.width - 80,self.view.bounds.height-footerBaner.frame.height-70,60,100))
        manuBtn.setTitle("MENU",  forState: .Normal)
        manuBtn.setImage(manuBtnNextImage, forState: .Normal)
        manuBtn.addTarget(self, action: "tapManuBtn:", forControlEvents: .TouchUpInside)
        manuBtn.sizeToFit()
        self.view.addSubview(manuBtn)
        
        mainBtn = UIButton(frame: CGRectMake(180,self.view.bounds.height-footerBaner.frame.height-70,100,100))
        mainBtn.setImage(mainBtnActImage, forState: .Normal)
        mainBtn.addTarget(self, action: "tapMainBtn:", forControlEvents: .TouchUpInside)
        manuBtn.sizeToFit()
        self.view.addSubview(mainBtn)
        
        detailBtn = UIButton(frame: CGRectMake(120,self.view.bounds.height-footerBaner.frame.height-70,60,100))
        detailBtn.setImage(detailBtnActImage, forState: .Normal)
        detailBtn.addTarget(self, action: "tapDetailBtn:", forControlEvents: .TouchUpInside)
        detailBtn.sizeToFit()
        self.view.addSubview(detailBtn)
        
        shareBtn = UIButton(frame: CGRectMake(60,self.view.bounds.height-footerBaner.frame.height-70,60,100))
        shareBtn.setImage(shareBtnActImage, forState: .Normal)
        shareBtn.addTarget(self, action: "tapShareBtn:", forControlEvents: .TouchUpInside)
        shareBtn.sizeToFit()
        self.view.addSubview(shareBtn)
        
        configBtn = UIButton(frame: CGRectMake(0,self.view.bounds.height-footerBaner.frame.height-70,60,100))
        configBtn.setImage(configBtnActImage, forState: .Normal)
        configBtn.addTarget(self, action: "tapConfigBtn:", forControlEvents: .TouchUpInside)
        configBtn.sizeToFit()
        self.view.addSubview(configBtn)
        
        // メニューボタン以外のボタンを非表示にする
        mainBtn.hidden = true
        detailBtn.hidden = true
        shareBtn.hidden = true
        configBtn.hidden = true
        
        // テーマソングを再生する.
        do {
            myAudioPlayer = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath:mySongPath!))
            myAudioPlayer.numberOfLoops = -1
            myAudioPlayer.play()
            
        }catch{
            // 例外発生
        }
    }

    
    /** 履歴書メニューのポップアップ作成 **/
    func detailInit()
    {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
//        //ポップ生成
//        detailConView = UIView(frame: CGRectMake(18,100,340,400))
//        detailImgView = UIImageView()
//        detailImgView.frame.size = detailConView.frame.size
//        detailImgSubView = UIImageView(frame: CGRectMake(20,50,detailConView.frame.width-60,detailConView.frame.height-60))
//        
//        // ポップの背景を設定する.
//        detailImgView.image = detailViewImage
//        detailImgView.alpha = 0.9
//        detailImgSubView.image = detailViewSubImage
//        detailImgSubView.alpha = 0.9
//        
//        // 初期表示は非表示
//        detailConView.hidden = true
//        
//        // ViewをViewに追加する.
//        self.view.addSubview(detailConView)
//        
//        self.nameDataLabel = UILabel(frame: CGRectMake(130,10,200,20))
//        self.nameDataLabel.text = "こうじ"
//        self.birthDataLabel = UILabel(frame: CGRectMake(130,30,200,20))
//        self.birthDataLabel.text = "1990年3月31日"
//        self.positionDataLabel = UILabel(frame: CGRectMake(130,50,200,20))
//        self.positionDataLabel.text = "ひきニート"
//        self.compDataLabel = UILabel(frame: CGRectMake(130,70,200,30))
//        self.compDataLabel.text = "部屋、台所、トイレ"
//        self.kakugenDataLabel = UILabel(frame: CGRectMake(130,100,200,20))
//        self.kakugenDataLabel.text = "やる気！元気！いわき！"
//        
//        // ポップ上に表示するオブジェクトをViewに追加する.
//        detailConView.addSubview(detailImgView)
//        detailConView.addSubview(detailImgSubView)
//        detailConView.addSubview(nameDataLabel)
//        detailConView.addSubview(birthDataLabel)
//        detailConView.addSubview(positionDataLabel)
//        detailConView.addSubview(compDataLabel)
//        detailConView.addSubview(kakugenDataLabel)
    }
    
    
    
    
    
    
    /** シェアメニューのポップアップ作成 **/
    func shareInit()
    {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
//        //ポップ生成
//        shareConView = UIView(frame: CGRectMake(18,100,340,400))
//        shareImgView = UIImageView()
//        shareImgView.frame.size = shareConView.frame.size
//        
//        // ポップの背景を設定する.
//        shareImgView.image = shareViewImage
//        shareImgView.alpha = 0.9
//        
//        // 初期表示は非表示
//        shareConView.hidden = true
//        
//        // ViewをViewに追加する.
//        self.view.addSubview(shareConView)
//        
//        // FaceBookボタンを生成
//        facebookBtn = UIButton(frame: CGRectMake(20,120,50,50))
//        let facebookImage = self.getUncachedImage( named: "01_07_01.png")! as UIImage
//        facebookBtn.setImage(facebookImage, forState: .Normal)
//        facebookBtn.addTarget(self, action: "tapFacebookBtn:", forControlEvents: .TouchUpInside)
//        
//        // Twitterボタンを生成
//        twitterBtn = UIButton(frame: CGRectMake(100,120,50,50))
//        let twitterImage = self.getUncachedImage( named: "01_08_01.png")! as UIImage
//        twitterBtn.setImage(twitterImage, forState: .Normal)
//        twitterBtn.addTarget(self, action: "tapTwitterBtn:", forControlEvents: .TouchUpInside)
//        
//        // LINEボタンを生成
//        lineBtn = UIButton(frame: CGRectMake(180,120,50,50))
//        let lineImage = self.getUncachedImage( named: "01_09_01.png")! as UIImage
//        lineBtn.setImage(lineImage, forState: .Normal)
//        lineBtn.addTarget(self, action: "tapLineBtn:", forControlEvents: .TouchUpInside)
//        
//        // ポップ上に表示するオブジェクトをViewに追加する.
//        shareConView.addSubview(shareImgView)
//        shareConView.addSubview(facebookBtn)
//        shareConView.addSubview(twitterBtn)
//        shareConView.addSubview(lineBtn)
    }
    
    /** 設定メニューのポップアップ作成 **/
    func configInit()
    {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
//        //ポップ生成
//        configConView = UIView(frame: CGRectMake(18,100,340,400))
//        configImgView = UIImageView()
//        configImgView.frame.size = configConView.frame.size
//        
//        // ポップの背景を設定する.
//        configImgView.image = configViewImage
//        configImgView.alpha = 0.9
//        
//        // 初期表示は非表示
//        configConView.hidden = true
//        
//        // ポップアップViewをViewに追加する.
//        self.view.addSubview(configConView)
//        
//        // ポップ上に表示するオブジェクトを生成する.
//        // BGMのラベルを生成
//        bgmLabel = UILabel(frame: CGRectMake(20,60,100,120))
//        bgmLabel.text = "BGM"
//        
//        // BGMのスライドバーを生成
//        bgmVolumeSBar = UISlider(frame: CGRectMake(100,60,100,120))
//        bgmVolumeSBar.addTarget(self, action: "slideBgmVolume:", forControlEvents: .TouchUpInside)
//        bgmVolumeSBar.value = 0.5
//        
//        // BGMのミュートボタンを生成
//        bgmMuteBtn = UIButton(frame: CGRectMake(200,60,100,120))
//        bgmMuteBtn.setTitle("ミュート",  forState: .Normal)
//        bgmMuteBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
//        bgmMuteBtn.addTarget(self, action: "tapBgmMuteBtn:", forControlEvents: .TouchUpInside)
//        
//        // SEのラベルを生成
//        seLabel = UILabel(frame: CGRectMake(20,120,100,120))
//        seLabel.text = "SE"
//        
//        // SEのスライドバーを生成
//        seVolumeSBar = UISlider(frame: CGRectMake(100,120,100,120))
//        seVolumeSBar.addTarget(self, action: "slideSeVolume:", forControlEvents: .TouchUpInside)
//        seVolumeSBar.value = 0.5
//        
//        // SEのミュートボタンを生成
//        seMuteBtn = UIButton(frame: CGRectMake(200,120,100,120))
//        seMuteBtn.setTitle("ミュート",  forState: .Normal)
//        seMuteBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
//        seMuteBtn.addTarget(self, action: "tapSeMuteBtn:", forControlEvents: .TouchUpInside)
//        
//        // ポップ上に表示するオブジェクトをViewに追加する.
//        configConView.addSubview(configImgView)
//        configConView.addSubview(bgmLabel)
//        configConView.addSubview(bgmVolumeSBar)
//        configConView.addSubview(bgmMuteBtn)
//        configConView.addSubview(seLabel)
//        configConView.addSubview(seVolumeSBar)
//        configConView.addSubview(seMuteBtn)
        
    }

    //ニートを動かすアニメーション
    func animationStart() {
        print(NSDate().description, __FUNCTION__, __LINE__)
        animeTimer = NSTimer.scheduledTimerWithTimeInterval(0.0, target: self, selector: Selector("randomWalk"), userInfo: nil, repeats: true)
    }
   
    
    
    
    
    
    
//    /** SE再生 **/
//    func seSoundPlay(sePath: String)
//    {
//        print(NSDate().description, __FUNCTION__, __LINE__)
//
//        // SEを再生する.
//        do {
//            mySePlayer = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath:sePath))
////            mySePlayer.volume = seVolumeSBar.value * 2
//            mySePlayer.play()
//            
//        }catch{
//            // 例外発生
//        }
//    }

    
    /** バナーが読みこまれた時に呼ばれる **/
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        print(NSDate().description, __FUNCTION__, __LINE__)

        self.footerBaner?.hidden = false
        print("bannerViewDidLoadAd")
    }
    
    
    
    
    //ランダムウォーク
    func randomWalk() {
        print(NSDate().description, __FUNCTION__, __LINE__)
        //("x = \(self.myCharImageView.center.x) y = \(self.myCharImageView.center.y)")

        //初期値
        var x: CGFloat = 0.0
        var y: CGFloat = 0.0
        var wkX: CGFloat
        var wkY: CGFloat
        let curX = self.myCharImageView.frame.origin.x
        let curY = self.myCharImageView.frame.origin.y
        
        
        //動く方向を決める(8方向)
        repeat {
            wkX = 0.0
            wkY = 0.0
        
            let indexX = Int(arc4random_uniform(3))
            switch indexX {
            case 0:
                wkX = -20.0
            case 1:
                wkX = 20.0
            default:
                wkX = 0.0
            }
        
            let indexY = Int(arc4random_uniform(3))
            switch indexY {
            case 0:
                wkY = -20.0
            case 1:
                wkY = 20.0
            default:
                wkY = 0.0
            }
            //TODO:画面範囲内の場合のみ移動先を設定
            if 30 <= (curX+wkX) &&
                (curX+wkX) <= self.view.bounds.width - 30 &&
               30 <= (curY+wkY) &&
                (curY+wkY) <= self.view.bounds.height - 30 {
                    x = wkX
                    y = wkY
            }
        } while (x == 0.0 && y == 0.0)
    

        //print("x = \(x) y = \(y)")

        // キャラクターアニメーションを設定する.
        var charaImages :[UIImage]?

        if curX == curX+x && curY <= curY+y {
            charaImages = [
                Utility.getUncachedImage( named: "04_01_01_01_04.PNG")!,
                Utility.getUncachedImage( named: "04_01_01_01_05.PNG")!,
                Utility.getUncachedImage( named: "04_01_01_01_04.PNG")!,
                Utility.getUncachedImage( named: "04_01_01_01_06.PNG")!
        ]
        
        } else if curX == curX+x && curY > curY+y {
            charaImages = [
                Utility.getUncachedImage( named: "04_01_01_01_01.PNG")!,
                Utility.getUncachedImage( named: "04_01_01_01_02.PNG")!,
                Utility.getUncachedImage( named: "04_01_01_01_01.PNG")!,
                Utility.getUncachedImage( named: "04_01_01_01_03.PNG")!
        ]
        
        } else if curX <= curX+x  {
            charaImages = [
                Utility.getUncachedImage( named: "04_01_01_01_07.PNG")!,
                Utility.getUncachedImage( named: "04_01_01_01_08.PNG")!,
                Utility.getUncachedImage( named: "04_01_01_01_07.PNG")!,
                Utility.getUncachedImage( named: "04_01_01_01_09.PNG")!
            ]
        }else if curX > curX+x {
            charaImages = [
                Utility.getUncachedImage( named: "04_01_01_01_10.PNG")!,
                Utility.getUncachedImage( named: "04_01_01_01_11.PNG")!,
                Utility.getUncachedImage( named: "04_01_01_01_10.PNG")!,
                Utility.getUncachedImage( named: "04_01_01_01_12.PNG")!
            ]
            
        }
        
        self.myCharImageView.animationImages = charaImages
        self.myCharImageView.animationDuration = 3
        self.myCharImageView.startAnimating()
        
        // 移動
        UIView.animateWithDuration(
            2.0, // アニメーションの時間
            delay:0.0,
            options:[UIViewAnimationOptions.TransitionCrossDissolve
                ,UIViewAnimationOptions.AllowUserInteraction],
            animations: {() -> Void  in
                
            self.myCharImageView.frame.origin.x += x
            self.myCharImageView.frame.origin.y += y
                
            },
            completion: {(
                finished: Bool) -> Void in
            }
        )

        //タイマー再設定
        animeTimer.invalidate()
        animeTimer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: Selector("randomWalk"), userInfo: nil, repeats: true)
    }


    /** 全オブジェクトの制約設定 **/
    func objConstraints() {
        print(NSDate().description, __FUNCTION__, __LINE__)
   
        manuBtn.translatesAutoresizingMaskIntoConstraints = false
        mainBtn.translatesAutoresizingMaskIntoConstraints = false
        detailBtn.translatesAutoresizingMaskIntoConstraints = false
        shareBtn.translatesAutoresizingMaskIntoConstraints = false
        configBtn.translatesAutoresizingMaskIntoConstraints = false
        
        // メニューボタンの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.manuBtn,
                attribute:  NSLayoutAttribute.Right,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.Right,
                multiplier: 1.0,
                constant: -10
            ),

            // y座標
            NSLayoutConstraint(
                item: self.manuBtn,
                attribute: NSLayoutAttribute.Bottom,
                relatedBy: .Equal,
                toItem: self.footerBaner,
                attribute:  NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: -10
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.manuBtn,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0 / 6.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.manuBtn,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0 / 12.0,
                constant: 0
            )]
        )
        
        // メインボタンの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.mainBtn,
                attribute:  NSLayoutAttribute.Right,
                relatedBy: .Equal,
                toItem: self.manuBtn,
                attribute:  NSLayoutAttribute.Left,
                multiplier: 1.0,
                constant: -10
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.mainBtn,
                attribute: NSLayoutAttribute.Top,
                relatedBy: .Equal,
                toItem: self.manuBtn,
                attribute:  NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.mainBtn,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.manuBtn,
                attribute: .Width,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.mainBtn,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.manuBtn,
                attribute: .Height,
                multiplier: 1.0,
                constant: 0
            )]
        )

        // 履歴書ボタンの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.detailBtn,
                attribute:  NSLayoutAttribute.Right,
                relatedBy: .Equal,
                toItem: self.mainBtn,
                attribute:  NSLayoutAttribute.Left,
                multiplier: 1.0,
                constant: -10
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.detailBtn,
                attribute: NSLayoutAttribute.Top,
                relatedBy: .Equal,
                toItem: self.manuBtn,
                attribute:  NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.detailBtn,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.manuBtn,
                attribute: .Width,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.detailBtn,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.manuBtn,
                attribute: .Height,
                multiplier: 1.0,
                constant: 0
            )]
        )

        // シェアボタンの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.shareBtn,
                attribute:  NSLayoutAttribute.Right,
                relatedBy: .Equal,
                toItem: self.detailBtn,
                attribute:  NSLayoutAttribute.Left,
                multiplier: 1.0,
                constant: -10
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.shareBtn,
                attribute: NSLayoutAttribute.Top,
                relatedBy: .Equal,
                toItem: self.manuBtn,
                attribute:  NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.shareBtn,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.manuBtn,
                attribute: .Width,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.shareBtn,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.manuBtn,
                attribute: .Height,
                multiplier: 1.0,
                constant: 0
            )]
        )

        // 設定ボタンの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.configBtn,
                attribute:  NSLayoutAttribute.Right,
                relatedBy: .Equal,
                toItem: self.shareBtn,
                attribute:  NSLayoutAttribute.Left,
                multiplier: 1.0,
                constant: -10
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.configBtn,
                attribute: NSLayoutAttribute.Top,
                relatedBy: .Equal,
                toItem: self.manuBtn,
                attribute:  NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.configBtn,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.manuBtn,
                attribute: .Width,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.configBtn,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.manuBtn,
                attribute: .Height,
                multiplier: 1.0,
                constant: 0
            )]
        )
    }
    
    //****************************************
    // MARK: - Collection View Delegate
    //****************************************
    
    //****************************************
    // MARK: - DB Access
    //****************************************

    //迷言の取得
    func getMeigen() -> String  {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        let meigenList :[M_Kakugen] = M_Kakugen.MR_findAll() as! [M_Kakugen];
        let randInt = arc4random_uniform(UInt32(meigenList.count));
        print(meigenList.count)
        return meigenList[Int(randInt)].meigenText
        
    }

    
}

