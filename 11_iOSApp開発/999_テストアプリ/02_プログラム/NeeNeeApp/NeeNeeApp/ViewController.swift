//
//  ViewController.swift
//  NeeNeeApp
//
//  Created by 石川晃次 on 2015/12/27.
//  Copyright © 2015年 KojiIshikawa. All rights reserved.
//

import UIKit
import Social
import iAd
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIGestureRecognizerDelegate {

    // 壁紙オブジェクト
    private var myImageView: UIImageView!
    
    // キャラクターオブジェクト
    private var myCharImageView: UIImageView!
    
    // 吹き出しオブジェクト
    private var myFukidasiImageView: UIImageView!
    private var fukidasiLabel: UILabel!

    // BGM・SEの再生用オブジェクト
    private var myAudioPlayer: AVAudioPlayer!
    private var mySePlayer: AVAudioPlayer!
    
    // メニューボタン
    private var manuBtn: UIButton!
    private var mainBtn: UIButton!
    private var detailBtn: UIButton!
    private var shareBtn: UIButton!

    // メニューのサブビュー
    private var mainConView: UIView!
    private var detailConView: UIView!
    private var shareConView: UIView!
    private var configConView: UIView!
    
    // 暇つぶしメニューのオブジェクト
    var itemCollectionView: UICollectionView!
    private var setItem1View: UIImageView!
    private var setItem2View: UIImageView!
    private var setItem3View: UIImageView!
    
    // 履歴書メニューのオブジェクト
    private var nameTitleLabel: UILabel!
    private var nameDataLabel: UILabel!
    private var birthTitleLabel: UILabel!
    private var birthDataLabel: UILabel!
    private var positionTitleLabel: UILabel!
    private var positionDataLabel: UILabel!
    private var compTitleLabel: UILabel!
    private var compDataLabel: UILabel!
    private var kakugenTitleLabel: UILabel!
    private var kakugenDataLabel: UILabel!
    private var himaTitleLabel: UILabel!
    private var himaDataLabel: UILabel!
    
    // シェアメニューのオブジェクト
    private var facebookBtn: UIButton!
    private var lineBtn: UIButton!
    private var twitterBtn: UIButton!
    private var configBtn: UIButton!
    
    // 設定メニューのオブジェクト
    private var bgmMuteBtn: UIButton!
    private var bgmVolumeSBar: UISlider!
    private var bgmLabel: UILabel!
    private var seMuteBtn: UIButton!
    private var seVolumeSBar: UISlider!
    private var seLabel: UILabel!

    // バナー
    private var footerBaner: ADBannerView!
    
    // 定数宣言
    private let mySongPath = NSBundle.mainBundle().pathForResource("暇で忙しい", ofType:"mp3")
    private let mySeYesPath = NSBundle.mainBundle().pathForResource("se4", ofType:"mp3")
    private let mySeNoPath = NSBundle.mainBundle().pathForResource("se6", ofType:"mp3")
    private let myImage = UIImage(named: "s-01_1.JPG")
    private let fukidasiImage = UIImage( named: "fukidasi.png")!

    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /* 以下の行を追加する */
        
        // UIImageViewを作成する.
        myImageView = UIImageView(frame: CGRectMake(0,0,self.view.bounds.width,self.view.bounds.height))
        
        // 画像をUIImageViewに設定する.
        myImageView.image = myImage
        
        // キャラクターを初期設定する.
        // UIImageViewをViewに追加する.
        self.view.addSubview(myImageView)
        myCharImageView = UIImageView(frame: CGRectMake(-100,300,300,350))
        myCharImageView.tag = 1
        
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
        
        // キャラクターをタップ可能にする.
        myCharImageView.userInteractionEnabled = true
        let charaTap:UITapGestureRecognizer
             = UITapGestureRecognizer(target: self, action: "tapCharaImage:")
        myCharImageView.addGestureRecognizer(charaTap)
        
        // キャラクターを移動させる（無限ループ）
        callbackCharaMove()

        // UIImageViewをViewに追加する.
        self.view.addSubview(myCharImageView)
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
        manuBtn.addTarget(self, action: "tapManuBtn:", forControlEvents: .TouchUpInside)
        self.view.addSubview(manuBtn)
        
        mainBtn = UIButton(frame: CGRectMake(180,self.view.bounds.height-footerBaner.frame.height-70,100,100))
        mainBtn.setTitle("ひまつぶし",  forState: .Normal)
        mainBtn.addTarget(self, action: "tapMainBtn:", forControlEvents: .TouchUpInside)
        self.view.addSubview(mainBtn)
        
        detailBtn = UIButton(frame: CGRectMake(120,self.view.bounds.height-footerBaner.frame.height-70,60,100))
        detailBtn.setTitle("履歴書",  forState: .Normal)
        detailBtn.addTarget(self, action: "tapDetailBtn:", forControlEvents: .TouchUpInside)
        self.view.addSubview(detailBtn)
        
        shareBtn = UIButton(frame: CGRectMake(60,self.view.bounds.height-footerBaner.frame.height-70,60,100))
        shareBtn.setTitle("シェア",  forState: .Normal)
        shareBtn.addTarget(self, action: "tapShareBtn:", forControlEvents: .TouchUpInside)
        self.view.addSubview(shareBtn)
        
        configBtn = UIButton(frame: CGRectMake(0,self.view.bounds.height-footerBaner.frame.height-70,60,100))
        configBtn.setTitle("設定",  forState: .Normal)
        configBtn.addTarget(self, action: "tapConfigBtn:", forControlEvents: .TouchUpInside)
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
        
        // メイン（ひまつぶし）メニューの生成
        mainInit()

        // 履歴書メニューの生成
        detailInit()
        
        // シェアメニューの生成
        shareInit()
        
        // 設定メニューの生成
        configInit()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("didReceiveMemoryWarning")
    }
    
    /** メニューボタン押下時の処理 **/
    func tapManuBtn(sender: AnyObject) {
        
        if  manuBtn.titleLabel?.text == "MENU" {
            
            // ボタンの文言を変える
            manuBtn.setTitle("×",  forState: .Normal)
            
            // メニュー内ボタンの制御を切り替える.
            mainBtn.hidden = false
            detailBtn.hidden = false
            shareBtn.hidden = false
            configBtn.hidden = false

            // SEを再生する.
            seSoundPlay(mySeYesPath!)
            
        } else {
            
            // ボタンの文言を変える
            manuBtn.setTitle("MENU",  forState: .Normal)
            
            // メニュー内ボタンの制御を切り替える.
            mainBtn.hidden = true
            detailBtn.hidden = true
            shareBtn.hidden = true
            configBtn.hidden = true
            
            // SEを再生する.
            seSoundPlay(mySeNoPath!)
        
        }
    }
    
    /** ひまつぶしボタン押下時の処理 **/
    func tapMainBtn(sender: AnyObject) {
        
        // SEを再生する.
        seSoundPlay(mySeYesPath!)
        
        // ポップの表示・非表示を切り替える.
        mainConView.hidden = mainConView.hidden ? false:true
        
        // その他メニューボタンの制御を切り替える.
        manuBtn.userInteractionEnabled = mainConView.hidden ? true:false
        detailBtn.userInteractionEnabled = mainConView.hidden ? true:false
        shareBtn.userInteractionEnabled = mainConView.hidden ? true:false
        configBtn.userInteractionEnabled = mainConView.hidden ? true:false
}
    
    func tapDetailBtn(sender: AnyObject) {
        
        // SEを再生する.
        seSoundPlay(mySeYesPath!)
        
        // ポップの表示・非表示を切り替える.
        detailConView.hidden = detailConView.hidden ? false:true
        
        // その他メニューボタンの制御を切り替える.
        manuBtn.userInteractionEnabled = detailConView.hidden ? true:false
        mainBtn.userInteractionEnabled = detailConView.hidden ? true:false
        shareBtn.userInteractionEnabled = detailConView.hidden ? true:false
        configBtn.userInteractionEnabled = detailConView.hidden ? true:false
    }
    
    /** シェアボタン押下時の処理 **/
    func tapShareBtn(sender: AnyObject) {
        
        // SEを再生する.
        seSoundPlay(mySeYesPath!)
        
        // ポップの表示・非表示を切り替える.
        shareConView.hidden = shareConView.hidden ? false:true

        // その他メニューボタンの制御を切り替える.
        manuBtn.userInteractionEnabled = shareConView.hidden ? true:false
        mainBtn.userInteractionEnabled = shareConView.hidden ? true:false
        detailBtn.userInteractionEnabled = shareConView.hidden ? true:false
        configBtn.userInteractionEnabled = shareConView.hidden ? true:false
        
    }

    /** 設定ボタン押下時の処理 **/
    func tapConfigBtn(sender: AnyObject) {
        
        // SEを再生する.
        seSoundPlay(mySeYesPath!)
        
        // オブジェクトの表示・非表示を切り替える.
        configConView.hidden = configConView.hidden ? false:true
        
        // その他メニューボタンの制御を切り替える.
        manuBtn.userInteractionEnabled = configConView.hidden ? true:false
        mainBtn.userInteractionEnabled = configConView.hidden ? true:false
        detailBtn.userInteractionEnabled = configConView.hidden ? true:false
        shareBtn.userInteractionEnabled = configConView.hidden ? true:false
    }
    
    /** BGMミュートボタン押下時の処理 **/
    func tapBgmMuteBtn(sender: AnyObject) {
        
        // SEを再生する.
        seSoundPlay(mySeYesPath!)
        
        // ミュート切り替え
        if myAudioPlayer.volume == 0.0 {
            
            myAudioPlayer.volume = 0.5
            bgmVolumeSBar.value = 0.5
            
        } else {
            
            myAudioPlayer.volume = 0.0
            bgmVolumeSBar.value = 0.0
        }
    }

    /** BGMボリューム変更時の処理 **/
    func slideBgmVolume(sender: AnyObject) {
        
        // スライド値をBGM音量にセットする
        myAudioPlayer.volume = bgmVolumeSBar.value
        
    }

    /** SEミュートボタン押下時の処理 **/
    func tapSeMuteBtn(sender: AnyObject) {
        
        // SEを再生する.
        seSoundPlay(mySeYesPath!)
        
        // ミュート切り替え
        if mySePlayer.volume == 0.0 {
            
            mySePlayer.volume = 1.0
            seVolumeSBar.value = 0.5
            
        } else {
            
            mySePlayer.volume = 0.0
            seVolumeSBar.value = 0.0
        }
    }
    
    /** SEボリューム変更時の処理 **/
    func slideSeVolume(sender: AnyObject) {
        
        // スライド値をBGM音量にセットする
        mySePlayer.volume = seVolumeSBar.value * 2
        
    }

    func tapCharaImage(sender: UITapGestureRecognizer) {
        
    }
    
    //facebookボタン押下時の処理
    func tapFacebookBtn(sender: AnyObject) {
        
        // Facebookの投稿ダイアログを作って
        let cv = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        // 画像を追加
        cv.addImage(UIImage(named: "facebook.png"))
        // 投稿ダイアログを表示する
        self.presentViewController(cv, animated: true, completion: nil)
    }
    
    //ラインボタン押下時の処理
    func tapLineBtn(sender: AnyObject) {
        
        //　共有する項目
        let shareImage = UIImage(named: "LINEActivityIcon.png")!
        let shareItems = [shareImage]
        
        // LINEで送るボタンを追加
        let line = LINEActivity()
        let avc = UIActivityViewController(activityItems: shareItems, applicationActivities: [line])
        
        presentViewController(avc, animated: true, completion: nil)
    }
    
    //Twitterボタン押下時の処理
    func tapTwitterBtn(sender: AnyObject) {
        
        // 共有する項目
        // Twitterの投稿ダイアログを作って
        let cv = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        // 文字を追加
        cv.setInitialText("メッセージを入力してください。")
        // 投稿ダイアログを表示する
        self.presentViewController(cv, animated: true, completion:nil )
    }
    
    // 画面にタッチで呼ばれる
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        // タッチイベントを取得
        let touchEvent = touches.first!

        print(touchEvent.view?.tag.description)
        
        // キャラクター画像がタップされた場合かつ、メニューが非表示の場合
        if touchEvent.view?.tag == 1
        && mainConView.hidden == true
        && detailConView.hidden == true
        && shareConView.hidden == true
        && configConView.hidden == true
        {
            if self.myFukidasiImageView.hidden
            {
                // ダイアログを表示
                let alertController = UIAlertController(title: "ニートの格言入手", message: "チラシを表示して、今日のニートの格言を取得しますか？", preferredStyle: .Alert)
                
                let defaultActionYes = UIAlertAction(title: "表示する", style: .Default, handler:{
                    (action:UIAlertAction!) -> Void in
                    
                    // iAd(インタースティシャル)の表示
                    self.requestInterstitialAdPresentation()
                    
                    // 吹き出しの表示
                    self.myFukidasiImageView.hidden = false
                    self.fukidasiLabel.text = "やる気！元気！いわき！"
                    
                })
                
                let defaultActionNo = UIAlertAction(title: "表示しない", style: .Default, handler: nil)
                alertController.addAction(defaultActionYes)
                alertController.addAction(defaultActionNo)
                
                presentViewController(alertController, animated: true, completion: nil)
            
            } else {
                self.myFukidasiImageView.hidden = true
            }
            
        }
        
        
    }
    
    /** キャラクター移動設定用 **/
    func callbackCharaMove() {
        
        // 開始位置を設定する.
        myCharImageView.animationDuration = 4.0
        
        // キャラクターアニメーションを設定する.
        autoreleasepool {
        let charaImages = [
            UIImage( named: "c-01-l-1.PNG")!,
            UIImage( named: "c-01-l-2.PNG")!,
            UIImage( named: "c-01-l-1.PNG")!,
            UIImage( named: "c-01-l-3.PNG")!
        ]
        myCharImageView.animationImages = charaImages
        }

        self.myCharImageView.startAnimating()

        // 左→右の横移動
        UIView.animateWithDuration(
            8.0, // アニメーションの時間
            delay:1.0,
            options:[UIViewAnimationOptions.TransitionCrossDissolve
                    ,UIViewAnimationOptions.AllowUserInteraction],
            animations: {() -> Void  in
                
                // 左端から右端へ移動
                self.myCharImageView.frame.origin.x
                    = UIScreen.mainScreen().bounds.width - 200
            },
            completion: {(finished: Bool) -> Void in
                
                // 後ろ移動
                // キャラクターアニメーションを設定する.
                autoreleasepool {
                let charaImages = [
                    UIImage( named: "c-01-b-1.PNG")!,
                    UIImage( named: "c-01-b-2.PNG")!,
                    UIImage( named: "c-01-b-1.PNG")!,
                    UIImage( named: "c-01-b-3.PNG")!
                ]
                self.myCharImageView.animationImages = charaImages
                }
                self.myCharImageView.startAnimating()
                
                // アニメーション終了後の処理
                UIView.animateWithDuration(
                    4.0, // アニメーションの時間
                    delay:2.0,
                    options:[UIViewAnimationOptions.TransitionCrossDissolve
                            ,UIViewAnimationOptions.AllowUserInteraction],
                    animations: {() -> Void  in
                        self.myCharImageView.frame.origin.y
                            = self.myCharImageView.frame.origin.y - 30
                    },
                    completion: {(finished: Bool) -> Void in
                        
                        // 右→左の横移動
                        // キャラクターアニメーションを設定する.
                        autoreleasepool {
                        let charaImages = [
                            UIImage( named: "c-01-r-1.PNG")!,
                            UIImage( named: "c-01-r-2.PNG")!,
                            UIImage( named: "c-01-r-1.PNG")!,
                            UIImage( named: "c-01-r-3.PNG")!
                        ]
                        self.myCharImageView.animationImages = charaImages
                        }
                        self.myCharImageView.startAnimating()
                        
                        UIView.animateWithDuration(
                            8.0, // アニメーションの時間
                            delay:1.0,
                            options:[UIViewAnimationOptions.TransitionCrossDissolve,UIViewAnimationOptions.AllowUserInteraction],
                            animations: {() -> Void  in
                                self.myCharImageView.frame.origin.x = -100
                            },
                            completion: {(finished: Bool) -> Void in
                                
                                // 手前への移動
                                // キャラクターアニメーションを設定する.
                                let charaImages = [
                                    UIImage( named: "c-01-f-1.PNG")!,
                                    UIImage( named: "c-01-f-2.PNG")!,
                                    UIImage( named: "c-01-f-1.PNG")!,
                                    UIImage( named: "c-01-f-3.PNG")!
                                ]
                                self.myCharImageView.animationImages = charaImages
                                self.myCharImageView.startAnimating()
                                
                                // アニメーション終了後の処理
                                UIView.animateWithDuration(
                                    4.0, // アニメーションの時間
                                    delay:2.0,
                                    options:[UIViewAnimationOptions.TransitionCrossDissolve
                                            ,UIViewAnimationOptions.AllowUserInteraction],
                                    animations: {() -> Void  in
                                        self.myCharImageView.frame.origin.y
                                            = self.myCharImageView.frame.origin.y + 30
                                    },
                                    completion: {(finished: Bool) -> Void in
                                        
                                        // 繰り返し設定
                                        // キャラクターアニメーションを設定する.
                                        autoreleasepool {
                                        let charaImages = [
                                            UIImage( named: "c-01-l-1.PNG")!,
                                            UIImage( named: "c-01-l-2.PNG")!,
                                            UIImage( named: "c-01-l-1.PNG")!,
                                            UIImage( named: "c-01-l-3.PNG")!
                                        ]
                                        self.myCharImageView.animationImages = charaImages
                                        }
                                        // アニメーション終了後の処理
                                        // 再帰処理でアニメーションを繰り返す.
                                        self.callbackCharaMove()
                                })
                        })

                })
                
        })
        
    }
    
    /** SE再生 **/
    func seSoundPlay(sePath: String)
    {
        // SEを再生する.
        do {
            mySePlayer = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath:sePath))
            mySePlayer.volume = seVolumeSBar.value * 2
            mySePlayer.play()
            
        }catch{
            // 例外発生
        }
    }
    
    /** ひまつぶしメニューのポップアップ作成 **/
    func mainInit()
    {
        //ポップ生成
        mainConView = UIView(frame: CGRectMake(18,100,340,400))
        
        // ポップの背景色を設定する.
        mainConView.backgroundColor = UIColor(red: 20, green: 20, blue: 20, alpha: 0.9)
            
        // 初期表示は非表示
        mainConView.hidden = true
            
        // ViewをViewに追加する.
        self.view.addSubview(mainConView)

        // セット済みアイテムの初期設定.
        let setItem1Image = UIImage(named: "item.JPG")
        let setItem2Image = UIImage(named: "item.JPG")
        let setItem3Image = UIImage(named: "item.JPG")
        setItem1View = UIImageView(frame: CGRectMake(20,20,50,50))
        setItem2View = UIImageView(frame: CGRectMake(100,20,50,50))
        setItem3View = UIImageView(frame: CGRectMake(180,20,50,50))
        setItem1View.image = setItem1Image
        setItem2View.image = setItem2Image
        setItem3View.image = setItem3Image
        
        // 画像をUIImageViewに設定する.
        myImageView.image = myImage
        
        // CollectionViewのレイアウトを生成.
        let layout = UICollectionViewFlowLayout()
        
        // Cell一つ一つの大きさ.
        layout.itemSize = CGSizeMake(50, 50)
        
        // Cellのマージン.
        layout.sectionInset = UIEdgeInsetsMake(16, 16, 32, 16)
        
        // セクション毎のヘッダーサイズ.
        layout.headerReferenceSize = CGSizeMake(0,0)
        
        itemCollectionView = UICollectionView(frame: self.mainConView.frame, collectionViewLayout: layout)
        itemCollectionView.frame.origin.y = itemCollectionView.frame.origin.y - 20
        itemCollectionView.frame.size = CGSizeMake(itemCollectionView.frame.width - 44,itemCollectionView.frame.height - 100)
        itemCollectionView.registerClass(itemCell.self, forCellWithReuseIdentifier: "cell")
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
 
        // セル長押しイベント登録
        let longTapRecognizer = UILongPressGestureRecognizer(target: self, action: "cellLongTap:")
        longTapRecognizer.delegate = self
        itemCollectionView.addGestureRecognizer(longTapRecognizer)
        
        // ポップ上に表示するオブジェクトをViewに追加する.
        mainConView.addSubview(setItem1View)
        mainConView.addSubview(setItem2View)
        mainConView.addSubview(setItem3View)
        mainConView.addSubview(itemCollectionView)
        
        /**
        // 非表示にしておく.
        setItem1View.hidden = true
        setItem2View.hidden = true
        setItem3View.hidden = true
        itemCollectionView.hidden = true
        **/

    }
    
    /** 履歴書メニューのポップアップ作成 **/
    func detailInit()
    {
        //ポップ生成
        detailConView = UIView(frame: CGRectMake(18,100,340,400))
            
        // ポップの背景色を設定する.
        detailConView.backgroundColor = UIColor(red: 20, green: 20, blue: 20, alpha: 0.9)
            
        // 初期表示は非表示
        detailConView.hidden = true
            
        // ViewをViewに追加する.
        self.view.addSubview(detailConView)
        
        self.nameTitleLabel = UILabel(frame: CGRectMake(20,10,120,20))
        self.nameTitleLabel.text = "名前"
        
        self.nameDataLabel = UILabel(frame: CGRectMake(130,10,200,20))
        self.nameDataLabel.text = "こうじ"

        self.birthTitleLabel = UILabel(frame: CGRectMake(20,30,120,20))
        self.birthTitleLabel.text = "生年月日"
        
        self.birthDataLabel = UILabel(frame: CGRectMake(130,30,200,20))
        self.birthDataLabel.text = "1990年3月31日"
        
        self.positionTitleLabel = UILabel(frame: CGRectMake(20,50,120,20))
        self.positionTitleLabel.text = "役職"
        
        self.positionDataLabel = UILabel(frame: CGRectMake(130,50,200,20))
        self.positionDataLabel.text = "ひきニート"
        
        self.compTitleLabel = UILabel(frame: CGRectMake(20,70,120,30))
        self.compTitleLabel.text = "行った場所"
        self.compTitleLabel.numberOfLines = 2
        
        self.compDataLabel = UILabel(frame: CGRectMake(130,70,200,30))
        self.compDataLabel.text = "部屋、台所、トイレ"
        
        self.kakugenTitleLabel = UILabel(frame: CGRectMake(20,100,120,20))
        self.kakugenTitleLabel.text = "今日の格言"
        
        self.kakugenDataLabel = UILabel(frame: CGRectMake(130,100,200,20))
        self.kakugenDataLabel.text = "やる気！元気！いわき！"
        
        self.himaTitleLabel = UILabel(frame: CGRectMake(20,120,120,60))
        self.himaTitleLabel.text = "つぶせるひま"
        
        self.himaDataLabel = UILabel(frame: CGRectMake(130,120,200,120))
        self.himaDataLabel.text = "家でゴロゴロ" + "\n" + "近所の公園でブランコ" + "\n" + "台所で冷蔵庫あさり"
        self.himaDataLabel.numberOfLines = 3

        // ポップ上に表示するオブジェクトをViewに追加する.
        detailConView.addSubview(nameTitleLabel)
        detailConView.addSubview(nameDataLabel)
        detailConView.addSubview(birthTitleLabel)
        detailConView.addSubview(birthDataLabel)
        detailConView.addSubview(positionTitleLabel)
        detailConView.addSubview(positionDataLabel)
        detailConView.addSubview(compTitleLabel)
        detailConView.addSubview(compDataLabel)
        detailConView.addSubview(kakugenTitleLabel)
        detailConView.addSubview(kakugenDataLabel)
        //detailConView.addSubview(himaTitleLabel)
        //detailConView.addSubview(himaDataLabel)
    }

    /** シェアメニューのポップアップ作成 **/
    func shareInit()
    {
        //ポップ生成
        shareConView = UIView(frame: CGRectMake(18,100,340,400))
            
        // ポップの背景色を設定する.
        shareConView.backgroundColor = UIColor(red: 20, green: 20, blue: 20, alpha: 0.9)
            
        // 初期表示は非表示
        shareConView.hidden = true
            
        // ViewをViewに追加する.
        self.view.addSubview(shareConView)
        
        // FaceBookボタンを生成
        facebookBtn = UIButton(frame: CGRectMake(20,120,50,50))
        let facebookImage = UIImage(named: "facebook.png")! as UIImage
        facebookBtn.setImage(facebookImage, forState: .Normal)
        facebookBtn.addTarget(self, action: "tapFacebookBtn:", forControlEvents: .TouchUpInside)
        
        // Twitterボタンを生成
        twitterBtn = UIButton(frame: CGRectMake(100,120,50,50))
        let twitterImage = UIImage(named: "twitter.png")! as UIImage
        twitterBtn.setImage(twitterImage, forState: .Normal)
        twitterBtn.addTarget(self, action: "tapTwitterBtn:", forControlEvents: .TouchUpInside)
        
        // LINEボタンを生成
        lineBtn = UIButton(frame: CGRectMake(180,120,50,50))
        let lineImage = UIImage(named: "line.png")! as UIImage
        lineBtn.setImage(lineImage, forState: .Normal)
        lineBtn.addTarget(self, action: "tapLineBtn:", forControlEvents: .TouchUpInside)
        
        // ポップ上に表示するオブジェクトをViewに追加する.
        shareConView.addSubview(facebookBtn)
        shareConView.addSubview(twitterBtn)
        shareConView.addSubview(lineBtn)
    }

    /** 設定メニューのポップアップ作成 **/
    func configInit()
    {
        //ポップ生成
        configConView = UIView(frame: CGRectMake(18,100,340,400))
        
        // ポップの背景色を設定する.
        configConView.backgroundColor = UIColor(red: 20, green: 20, blue: 20, alpha: 0.9)
        
        // 初期表示は非表示
        configConView.hidden = true
        
        // ポップアップViewをViewに追加する.
        self.view.addSubview(configConView)
        
        // ポップ上に表示するオブジェクトを生成する.
        // BGMのラベルを生成
        bgmLabel = UILabel(frame: CGRectMake(20,60,100,120))
        bgmLabel.text = "BGM"
        
        // BGMのスライドバーを生成
        bgmVolumeSBar = UISlider(frame: CGRectMake(100,60,100,120))
        bgmVolumeSBar.addTarget(self, action: "slideBgmVolume:", forControlEvents: .TouchUpInside)
        bgmVolumeSBar.value = 0.5
        
        // BGMのミュートボタンを生成
        bgmMuteBtn = UIButton(frame: CGRectMake(200,60,100,120))
        bgmMuteBtn.setTitle("ミュート",  forState: .Normal)
        bgmMuteBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        bgmMuteBtn.addTarget(self, action: "tapBgmMuteBtn:", forControlEvents: .TouchUpInside)
        
        // SEのラベルを生成
        seLabel = UILabel(frame: CGRectMake(20,120,100,120))
        seLabel.text = "SE"
        
        // SEのスライドバーを生成
        seVolumeSBar = UISlider(frame: CGRectMake(100,120,100,120))
        seVolumeSBar.addTarget(self, action: "slideSeVolume:", forControlEvents: .TouchUpInside)
        seVolumeSBar.value = 0.5
        
        // SEのミュートボタンを生成
        seMuteBtn = UIButton(frame: CGRectMake(200,120,100,120))
        seMuteBtn.setTitle("ミュート",  forState: .Normal)
        seMuteBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        seMuteBtn.addTarget(self, action: "tapSeMuteBtn:", forControlEvents: .TouchUpInside)
        
        // ポップ上に表示するオブジェクトをViewに追加する.
        configConView.addSubview(bgmLabel)
        configConView.addSubview(bgmVolumeSBar)
        configConView.addSubview(bgmMuteBtn)
        configConView.addSubview(seLabel)
        configConView.addSubview(seVolumeSBar)
        configConView.addSubview(seMuteBtn)
        
    }
    
    /** バナーが読みこまれた時に呼ばれる **/
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        self.footerBaner?.hidden = false
        print("bannerViewDidLoadAd")
    }
    
    // Cellが選択された際に呼び出される
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        print("Num: \(indexPath.row)")
        
    }
    
    /** セクションの数 **/
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    /** 表示するセルの数 **/
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    /** セルが表示されるときに呼ばれる処理（1個のセルを描画する毎に呼び出されます） **/
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! itemCell

        // セルの情報を設定する.
        cell._name.text = "×"+"1"
        cell._img.image = UIImage(named: "item.jpg")

        // セルを返却する.
        return cell
    }
    
    /** 暇つぶしアイテム長押し時の処理 **/
    func cellLongTap(recognizer: UILongPressGestureRecognizer) {
        
        print("長押し")

        // 押された位置でcellのPathを取得
        let point = recognizer.locationInView(itemCollectionView)

        let indexPath = self.itemCollectionView.indexPathForItemAtPoint(point)
        
        if indexPath == nil {
            
        } else if recognizer.state == UIGestureRecognizerState.Began  {
            // 長押しされた場合の処理
            print("長押しされたcellのindexPath:\(indexPath?.row)")
        }
    }
}

