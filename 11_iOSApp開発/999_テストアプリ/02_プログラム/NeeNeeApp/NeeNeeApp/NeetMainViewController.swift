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
    
    // バナー
    private var footerBaner: ADBannerView!
    
    // メニューボタン制御用
    private var manuBtnFlg = true
    
    // 壁紙オブジェクト
    private var myImageView: UIImageView!
    
    // キャラクターオブジェクト
    private var myCharImageView: UIImageView!

    // メニューボタン
    private var manuBtn: UIButton!
    private var mainBtn: UIButton!
    private var shareBtn: UIButton!
    private var detailBtn: UIButton!
    private var configBtn: UIButton!
    
    
    // メインの背景画像用オブジェクト
    private var mainImgView: UIImageView!
    private var mainImgSubView: UIImageView!

    //TODO:メモリ使用量削減のため、極力必要な時に、宣言、解放すること
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

    //アニメーションタイマー
    private var animeTimer: NSTimer!
    
    //初回表示判定フラグ
    private var isFirstLoad: Bool! = false

    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }
    

    //****************************************
    // MARK: - イベント
    //****************************************
    
    
    
    
    // view 初回ロード時
    override func viewDidLoad() {
        print(NSDate().description, __FUNCTION__, __LINE__)
        super.viewDidLoad()
        
        //行動中判定
        
        
        //オブジェクトの配置
        self.createObjInit()
        
        // オブジェクトの制約の設定
        self.objConstraints()
        
        //アニメーション開始
        self.animationStart()
        
        self.isFirstLoad = true
    }
    

    //view 表示完了後 毎回呼ばれる
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(false)

        if (self.isFirstLoad == true) {
            //ログインボーナス画面の表示
            self.showLoginBonus()
            self.isFirstLoad = false
        }
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
            Utility.seSoundPlay(Const.mySeYesPath!)
            
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
            Utility.seSoundPlay(Const.mySeNoPath!)
        
        }
    }
    

    //Popover表示
    func showPopoverView(sender: AnyObject, identifier:String) {
        let popoverView = self.storyboard!.instantiateViewControllerWithIdentifier(identifier) as UIViewController
//        popoverView.title = title
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
    
    func prepareForPopoverPresentation(popoverPresentationController: UIPopoverPresentationController) {
        print("prepare for presentation")
    }
    
    func popoverPresentationControllerShouldDismissPopover(popoverPresentationController: UIPopoverPresentationController) -> Bool {
        print("should dismiss")
        return true
    }
    
    func popoverPresentationControllerDidDismissPopover(popoverPresentationController: UIPopoverPresentationController) {
        print("did dismiss")
    }
    
    
//    //ポップオーバ閉じた際に呼ばれるメソッド
//    func popoverPresentationControllerDidDismissPopover(popoverView: UIPopoverPresentationController){
//        print()
//    }
    
    
    //Popover実装時に必要になるイベント　おまじない
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController)
        -> UIModalPresentationStyle {
            return .None
    }
    
    
    
    /** ひまつぶしボタン押下時の処理 **/
    func tapMainBtn(sender: AnyObject) {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        // SEを再生する.
        Utility.seSoundPlay(Const.mySeYesPath!)
        
        //PopOverを表示
        self.showPopoverView(sender, identifier: "ActionSetView")
        
    }

    //詳細ボタン押下時
    func tapDetailBtn(sender: AnyObject) {
        print(NSDate().description, __FUNCTION__, __LINE__)

        // SEを再生する.
        Utility.seSoundPlay(Const.mySeYesPath!)
        
        //PopOverを表示
        self.showPopoverView(sender, identifier: "ProfileView")
        
    }
    
    /** シェアボタン押下時の処理 **/
    func tapShareBtn(sender: AnyObject) {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        // SEを再生する.
        Utility.seSoundPlay(Const.mySeYesPath!)
        
        //PopOverを表示
        self.showPopoverView(sender, identifier: "SnsView")
        
    }

    /** 設定ボタン押下時の処理 **/
    func tapConfigBtn(sender: AnyObject) {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        // SEを再生する.
        Utility.seSoundPlay(Const.mySeYesPath!)
        
        //PopOverを表示
        self.showPopoverView(sender, identifier: "SettingView")
        
    }
    
    
//    // 画面にタッチで呼ばれる
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        print(NSDate().description, __FUNCTION__, __LINE__)
//        
//        // タッチイベントを取得
//        let touchEvent = touches.first!
//
//        //print(touchEvent.view?.tag.description)
//        
//        // キャラクター画像がタップされた場合かつ、メニューが非表示の場合
//        if touchEvent.view?.tag == 1
//        {
//            // ダイアログを表示
//            let alertController = UIAlertController(title: "ニートの格言入手", message: "チラシを表示して、今日のニートの格言を取得しますか？", preferredStyle: .Alert)
//            
//            let defaultActionYes = UIAlertAction(title: "表示する", style: .Default, handler:{
//                (action:UIAlertAction!) -> Void in
//                
//                // iAd(インタースティシャル)の表示
//                self.requestInterstitialAdPresentation()
//                
//                // TODO:吹き出しの表示
////                self.myFukidasiImageView.hidden = false
////                self.fukidasiLabel.text = self.getMeigen()
//                
//            })
//            
//            let defaultActionNo = UIAlertAction(title: "表示しない", style: .Default, handler: nil)
//            alertController.addAction(defaultActionYes)
//            alertController.addAction(defaultActionNo)
//            
//            presentViewController(alertController, animated: true, completion: nil)
//        }
//    }
    
    
    // ジェスチャーイベント処理
    func tapChara(gestureRecognizer: UITapGestureRecognizer){
        
//        // TODO:ダイアログを表示
//        let alertController = UIAlertController(title: "ニートの格言入手", message: "チラシを表示して、今日のニートの格言を取得しますか？", preferredStyle: .Alert)
//        
//        let defaultActionYes = UIAlertAction(title: "表示する", style: .Default, handler:{
//            (action:UIAlertAction!) -> Void in
//
//            // iAd(インタースティシャル)の表示
//            self.requestInterstitialAdPresentation()
//
//            self.showPopoverView(self.manuBtn, identifier: "KakugenView")
//            
//        })
//        
//        let defaultActionNo = UIAlertAction(title: "表示しない", style: .Default, handler: nil)
//        alertController.addAction(defaultActionYes)
//        alertController.addAction(defaultActionNo)
//
//        presentViewController(alertController, animated: true, completion: nil)

        self.showPopoverView(self.manuBtn, identifier: "KakugenView")

        
    }
    
    //****************************************
    // MARK: - その他メソッド
    //****************************************

    //ログインボーナス
    func showLoginBonus() {
        //PopOverを表示
        self.showPopoverView(self.manuBtn, identifier: "LoginBonusView")
    }
    
    
    
    //背景を取得
    func getBackGroundImage() ->UIImage {
        
        //TODO:現在行動中であれば、そのステージの背景を設定
        let stage = M_Stage.MR_findFirstByAttribute("stageID", withValue: 1)! as M_Stage
        return Utility.getUncachedImage(named: stage.imageBack)!
    }
    
    
    //初期表示時のオブジェクトを作成し設置する
    func createObjInit() {
        
        // 背景設定
        myImageView = UIImageView()
        myImageView.frame.size = CGSizeMake(self.view.bounds.width, self.view.bounds.height)
        myImageView.image = self.getBackGroundImage()
        self.view.addSubview(myImageView)
        
        //キャラクター設定
        // UIImageViewをViewに追加する.
        myCharImageView = UIImageView()
        myCharImageView.frame.size = CGSizeMake(self.view.bounds.width / 1.4, self.view.bounds.height / 1.8)
        myCharImageView.center.x = self.view.center.x
        myCharImageView.center.y = self.view.center.y
        myCharImageView.tag = 1
        myCharImageView.userInteractionEnabled = true
        let singleTap = UITapGestureRecognizer(target: self, action:"tapChara:")
        myCharImageView.addGestureRecognizer(singleTap)
        self.view.addSubview(myCharImageView)
        
        //TODO:オブジェクトの枠線表示
        myCharImageView.layer.borderColor = UIColor.redColor().CGColor
        myCharImageView.layer.borderWidth = 2.0
        
        // フッタのバナーを生成する.
        self.footerBaner = ADBannerView()
        self.footerBaner.frame.offsetInPlace(dx: 0, dy: self.view.bounds.height-footerBaner.frame.height)
        self.footerBaner?.hidden = false
        self.view.addSubview(footerBaner)
        
        // iAd(インタースティシャル)のマニュアル表示設定
        self.interstitialPresentationPolicy = ADInterstitialPresentationPolicy.Manual
        
        // メニューボタン及びサブメニューボタンの設定.
        manuBtn = UIButton()
        manuBtn.setTitle("MENU",  forState: .Normal)
        manuBtn.setImage(manuBtnNextImage, forState: .Normal)
        manuBtn.addTarget(self, action: "tapManuBtn:", forControlEvents: .TouchUpInside)
        manuBtn.sizeToFit()
        self.view.addSubview(manuBtn)
        
        //暇つぶしボタン
        mainBtn = UIButton()
        mainBtn.setImage(mainBtnActImage, forState: .Normal)
        mainBtn.addTarget(self, action: "tapMainBtn:", forControlEvents: .TouchUpInside)
        manuBtn.sizeToFit()
        self.view.addSubview(mainBtn)
        
        //履歴書ボタン
        detailBtn = UIButton()
        detailBtn.setImage(detailBtnActImage, forState: .Normal)
        detailBtn.addTarget(self, action: "tapDetailBtn:", forControlEvents: .TouchUpInside)
        detailBtn.sizeToFit()
        self.view.addSubview(detailBtn)
        
        //共有ボタン
        shareBtn = UIButton()
        shareBtn.setImage(shareBtnActImage, forState: .Normal)
        shareBtn.addTarget(self, action: "tapShareBtn:", forControlEvents: .TouchUpInside)
        shareBtn.sizeToFit()
        self.view.addSubview(shareBtn)
        
        //設定ボタン
        configBtn = UIButton()
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
        Utility.bgmSoundPlay(Const.mySongPath!)
    }

    /** バナーが読みこまれた時に呼ばれる **/
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        self.footerBaner?.hidden = false
        print("bannerViewDidLoadAd")
    }

    
    //ニートを動かすアニメーション
    func animationStart() {
        print(NSDate().description, __FUNCTION__, __LINE__)
        animeTimer = NSTimer.scheduledTimerWithTimeInterval(0.0, target: self, selector: Selector("randomWalk"), userInfo: nil, repeats: true)
    }

    
    //ランダムウォーク
    func randomWalk() {
        //print(NSDate().description, __FUNCTION__, __LINE__)
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
        //myCharImageView.translatesAutoresizingMaskIntoConstraints = false
        
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
        
                    /**
        // キャラクターイメージの制約
        self.view.addConstraints([

            // x座標
            NSLayoutConstraint(
                item: self.myCharImageView,
                attribute:  NSLayoutAttribute.CenterX,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.Left,
                multiplier: 1.0,
                constant: 150
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.myCharImageView,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 300
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.myCharImageView,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0 / 1.6,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.myCharImageView,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0 / 2.2,
                constant: 0
            )]
        )
**/

    }
    


    
}

