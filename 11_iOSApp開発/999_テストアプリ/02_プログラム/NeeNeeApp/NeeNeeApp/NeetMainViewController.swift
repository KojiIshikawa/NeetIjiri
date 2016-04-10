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

    //アニメーションタイマー
    private var animeTimer: NSTimer!

    //アクティブアイテム
    private var activeItem: [M_Item]!
    
    //キャラクターイメージ
    private var actionImages:[M_ActionImage]!
    
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

        //アクティブ時のイベントを受け取る.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "enterForeground:", name:"applicationWillEnterForeground", object: nil)

        //非アクティブ時のイベントを受け取る.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "enterBackground:", name:"applicationDidEnterBackground", object: nil)
        
        //オブジェクトの配置
        self.createObjInit()
        
        // オブジェクトの制約の設定
        self.objConstraints()
        
        self.isFirstLoad = true
    }
    

    //view 表示完了後 毎回呼ばれる
    override func viewDidAppear(animated: Bool) {
        print(NSDate().description, __FUNCTION__, __LINE__)

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

    //アクティブ時に動くイベント
    func enterForeground(notification: NSNotification){
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        // アクション進捗の最新化＆再描画する.
        self.isFirstLoad = false
        self.manuBtnFlg = true
        
        //オブジェクトの配置
        self.createObjInit()
        
        // オブジェクトの制約の設定
        self.objConstraints()
        
        self.isFirstLoad = true
    }

    //非アクティブ時に動くイベント
    func enterBackground(notification: NSNotification){
        print(NSDate().description, __FUNCTION__, __LINE__)
    }
    
    /** メニューボタン押下時の処理 **/
    func tapManuBtn(sender: AnyObject) {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        if  manuBtnFlg {
            
            // ボタンの文言を変える
            manuBtn.setImage(Utility.getUncachedImage(named: "01_02_01.png"),  forState: .Normal)
            manuBtnFlg = false
            
            // メニュー内ボタンの制御を切り替える.
            mainBtn.hidden = false
            detailBtn.hidden = false
            shareBtn.hidden = false
            configBtn.hidden = false

            // SEを再生する.
            Utility.seSoundPlay(Const.mySeYesPath)
            
        } else {
            
            // ボタンの文言を変える
            manuBtn.setImage(Utility.getUncachedImage(named: "01_01_01.png"),  forState: .Normal)
            manuBtnFlg = true
            
            // メニュー内ボタンの制御を切り替える.
            mainBtn.hidden = true
            detailBtn.hidden = true
            shareBtn.hidden = true
            configBtn.hidden = true
            
            // SEを再生する.
            Utility.seSoundPlay(Const.mySeNoPath)
        
        }
    }
    

    //Popover表示
    func showPopoverView(sender: AnyObject, identifier:String) {
        print(NSDate().description, __FUNCTION__, __LINE__)
        let popoverView = self.storyboard!.instantiateViewControllerWithIdentifier(identifier) as UIViewController
        popoverView.modalPresentationStyle = .Popover
        popoverView.preferredContentSize = self.view.bounds.size
        popoverView.view.backgroundColor = UIColor.clearColor()
        if let presentationController = popoverView.popoverPresentationController {
            presentationController.permittedArrowDirections = .Down
            presentationController.sourceView = sender as! UIButton
            presentationController.sourceRect = sender.bounds
            presentationController.delegate = self
            presentationController.popoverBackgroundViewClass = PopoverBackgroundView.classForCoder()
        }
        popoverView.title = identifier
        self.presentViewController(popoverView, animated: true, completion: nil)
    
    }
    
    func prepareForPopoverPresentation(popoverPresentationController: UIPopoverPresentationController) {
        print(NSDate().description, __FUNCTION__, __LINE__)
    }
    
    func popoverPresentationControllerShouldDismissPopover(popoverPresentationController: UIPopoverPresentationController) -> Bool {
        print(NSDate().description, __FUNCTION__, __LINE__)
        return true
    }
    
    //popOver表示終了後のイベント
    func popoverPresentationControllerDidDismissPopover(popoverPresentationController: UIPopoverPresentationController) {
        print(NSDate().description, __FUNCTION__, __LINE__)
        let identifier = popoverPresentationController.presentedViewController.title
        
        if (identifier == "LoginBonusView") {
            self.showPopoverView(self.manuBtn, identifier: "ResultView")
        }
        
    }
    
    //Popover実装時に必要になるイベント　おまじない
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController)
        -> UIModalPresentationStyle {
            return .None
    }
    
    
    
    /** ひまつぶしボタン押下時の処理 **/
    func tapMainBtn(sender: AnyObject) {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        // SEを再生する.
        Utility.seSoundPlay(Const.mySeYesPath)
        
        //PopOverを表示
        self.showPopoverView(sender, identifier: "ActionSetView")
        
    }

    //詳細ボタン押下時
    func tapDetailBtn(sender: AnyObject) {
        print(NSDate().description, __FUNCTION__, __LINE__)

        // SEを再生する.
        Utility.seSoundPlay(Const.mySeYesPath)
        
        //PopOverを表示
        self.showPopoverView(sender, identifier: "ProfileView")
        
    }
    
    /** シェアボタン押下時の処理 **/
    func tapShareBtn(sender: AnyObject) {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        // SEを再生する.
        Utility.seSoundPlay(Const.mySeYesPath)
        
        //PopOverを表示
        self.showPopoverView(sender, identifier: "SnsView")
        
    }

    /** 設定ボタン押下時の処理 **/
    func tapConfigBtn(sender: AnyObject) {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        // SEを再生する.
        Utility.seSoundPlay(Const.mySeYesPath)
        
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
        print(NSDate().description, __FUNCTION__, __LINE__)
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
//        })
//
//        let defaultActionNo = UIAlertAction(title: "表示しない", style: .Default, handler: nil)
//        alertController.addAction(defaultActionYes)
//        alertController.addAction(defaultActionNo)
//
//        presentViewController(alertController, animated: true, completion: nil)

//        self.showPopoverView(self.manuBtn, identifier: "KakugenView")

        
    }
    
    //****************************************
    // MARK: - その他メソッド
    //****************************************

    //ログインボーナス
    func showLoginBonus() {
        print(NSDate().description, __FUNCTION__, __LINE__)
        //PopOverを表示
        self.showPopoverView(self.manuBtn, identifier: "LoginBonusView")
    }
    
    //背景を取得
    func getBackGroundImage(_strImageFileName:String) ->UIImage {
        print(NSDate().description, __FUNCTION__, __LINE__)
        var imageBack = ""
        
        //現在行動中であれば、そのステージの背景を設定
        //行動中でなければ、デフォルトステージを設定
        if _strImageFileName > "" {

            imageBack = _strImageFileName
            
        } else {

            let stage = M_Stage.MR_findFirstByAttribute("stageID", withValue: 1)! as M_Stage
            imageBack = stage.imageBack
        }
        
        return Utility.getUncachedImage(named: imageBack)!
            
    }
    
    
    //初期表示時のオブジェクトを作成し設置する
    func createObjInit() {
        print(NSDate().description, __FUNCTION__, __LINE__)

        let activeItemId = self.updateSetAction()
        activeItem = Utility.getMItem(activeItemId)
        var activeStage = [M_Stage]()
        
        if activeItem.count >= 1 {
            activeStage = Utility.getMStage(Int(activeItem[0].stageID))
            actionImages = Utility.getMActionImage(Int(activeItem[0].itemID))
            
            // 所持ステージに書き込む.
            Utility.editT_RefStage(Int(activeItem[0].stageID))
            
        } else {
            
            // ない場合は先頭のデータを取得する.
            activeStage = Utility.getMStage(1)
            actionImages = Utility.getMActionImage(1)
        }
        
        // 背景設定
        myImageView = UIImageView()
        myImageView.frame.size = CGSizeMake(self.view.bounds.width, self.view.bounds.height)
        myImageView.image = self.getBackGroundImage(activeStage.count >= 1 ? activeStage[0].imageBack : "")
        self.view.addSubview(myImageView)
        
        //キャラクター設定
        // UIImageViewをViewに追加する.
        myCharImageView = UIImageView()
        myCharImageView.frame.size = CGSizeMake(self.view.bounds.width / 2.6
                                              , self.view.bounds.height / 3.0)
        
        myCharImageView.frame.origin.x = CGFloat(Float(self.view.bounds.width)
                                 * (Float(activeItem.count >= 1 ? activeItem[0].firstX : Const.CHARACTER_DEFAULT_FIRST_X) / 10))

        myCharImageView.frame.origin.y = CGFloat(Float(self.view.bounds.height)
                                 * (Float(activeItem.count >= 1 ? activeItem[0].firstY : Const.CHARACTER_DEFAULT_FIRST_Y) / 10))

        myCharImageView.tag = 1
        myCharImageView.userInteractionEnabled = true
        let singleTap = UITapGestureRecognizer(target: self, action:"tapChara:")
        myCharImageView.addGestureRecognizer(singleTap)
        self.view.addSubview(myCharImageView)
        
        
        //アニメーション開始
        //ただし、未設定時はランダムウォーク
        if activeItem.count >= 1 {
            
            switch activeItem[0].animeKBN {
                
                case Const.ANIME_KBN_TEITEN:
                    self.teitenKyoroKyoro()
                    break
                
                default:
                    self.animationStart()
                    break
            }
        } else {
            self.animationStart()
        }

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
        manuBtn.setImage(Utility.getUncachedImage(named: "01_01_01.png"), forState: .Normal)
        manuBtn.addTarget(self, action: "tapManuBtn:", forControlEvents: .TouchUpInside)
        manuBtn.sizeToFit()
        self.view.addSubview(manuBtn)
        
        //暇つぶしボタン
        mainBtn = UIButton()
        mainBtn.setImage(Utility.getUncachedImage(named: "01_03_01.png"), forState: .Normal)
        mainBtn.addTarget(self, action: "tapMainBtn:", forControlEvents: .TouchUpInside)
        manuBtn.sizeToFit()
        self.view.addSubview(mainBtn)
        
        //履歴書ボタン
        detailBtn = UIButton()
        detailBtn.setImage(Utility.getUncachedImage(named: "01_04_01.png"), forState: .Normal)
        detailBtn.addTarget(self, action: "tapDetailBtn:", forControlEvents: .TouchUpInside)
        detailBtn.sizeToFit()
        self.view.addSubview(detailBtn)
        
        //共有ボタン
        shareBtn = UIButton()
        shareBtn.setImage(Utility.getUncachedImage(named: "01_05_01.png"), forState: .Normal)
        shareBtn.addTarget(self, action: "tapShareBtn:", forControlEvents: .TouchUpInside)
        shareBtn.sizeToFit()
        self.view.addSubview(shareBtn)
        
        //設定ボタン
        configBtn = UIButton()
        configBtn.setImage(Utility.getUncachedImage(named: "01_06_01.png"), forState: .Normal)
        configBtn.addTarget(self, action: "tapConfigBtn:", forControlEvents: .TouchUpInside)
        configBtn.sizeToFit()
        self.view.addSubview(configBtn)
        
        // メニューボタン以外のボタンを非表示にする
        mainBtn.hidden = true
        detailBtn.hidden = true
        shareBtn.hidden = true
        configBtn.hidden = true
        
        // テーマソングを再生する.
        Utility.bgmSoundPlay(activeStage.count >= 1 ? activeStage[0].bgm : "")
        
        
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
        animeTimer = NSTimer.scheduledTimerWithTimeInterval(0.0, target: self, selector: "randomWalk", userInfo: nil, repeats: true)
    }
    
    /** セットアクション情報の更新 **/
    func updateSetAction() -> Int {
        print(NSDate().description, __FUNCTION__, __LINE__)
 
        // 更新対象のアクション（最大３件）を取得する.
        let actionFilter: NSPredicate =
        NSPredicate(format: "charaID = " + String(Const.CHARACTER1_ID) + " and actEndDate = null");
        let actionList :[T_ActionResult] = T_ActionResult.MR_findAllSortedBy("actSetDate,actStartDate", ascending: true, withPredicate: actionFilter) as! [T_ActionResult];

        // 完了済のアクションの最新１件を取得する.
        let oldActionFilter: NSPredicate =
        NSPredicate(format: "charaID = " + String(Const.CHARACTER1_ID) + " and actEndDate <> null");
        let oldActionList :[T_ActionResult] = T_ActionResult.MR_findAllSortedBy("actEndDate", ascending: false, withPredicate: oldActionFilter) as! [T_ActionResult];
        
        var activeItemId = -1
        var flgFirst = true
        var willStartDate: NSDate = NSDate()
        
        for action in actionList {
            
            // アクティブなアイテムが探知済の場合、それ以降のアイテムは処理しない.
            if activeItemId != -1 {
                break;
            }
            
            // 処理対象アクションのアイテム情報を取得する.
            let nowItem = Utility.getMItem(Int(action.itemID))
            
            // １件目の場合、スタート時間にセット時間＋開始までのインターバル時間(3分)を設定しておく.
            if flgFirst {

                let calendar = NSCalendar.currentCalendar()
                let comp = NSDateComponents()
                comp.second = Int(Const.ACTION_START_TIME_INTERVAL)
                
                // 前回のアクションが存在する場合は、１件目アクションのセット時間と
                // 前回アクションの終了時間を比較し、新しい方をスタート時間として採用する.
                if oldActionList.count > 0 &&
                    Float(oldActionList[0].actEndDate.timeIntervalSinceDate(action.actSetDate))
                    >= Float(0.0) {

                    willStartDate = calendar.dateByAddingComponents(
                        comp
                      , toDate:oldActionList[0].actEndDate
                      , options: NSCalendarOptions())!
                        
                } else {

                    willStartDate = calendar.dateByAddingComponents(
                        comp
                      , toDate: action.actSetDate
                      , options: NSCalendarOptions())!
                }
                
            }

            
            //スタート時間を、算出した時間で更新する.
            let updPredicate: NSPredicate = NSPredicate(
                format: "charaID = %@ AND itemID = %@ AND actSetDate = %@"
                , argumentArray:[action.charaID,String(action.itemID), action.actSetDate]);
            
            let updateData = T_ActionResult.MR_findFirstWithPredicate(updPredicate)! as T_ActionResult

            
            // スタート時間の更新
            // スタート時間が未設定かつ、インターバル時間を経過している場合
            if action.actStartDate == nil
                && Float(NSDate().timeIntervalSinceDate(willStartDate)) >= Float(0.0) {
                    
                    // 開始時間を更新する.
                    updateData.actStartDate = willStartDate
                    action.actStartDate = willStartDate
            }
            
            // スタート済のアクションが一定時間経過していたら、さらにエンド時間をセットさせ終了させる.
            if action.actStartDate != nil &&
                Float(NSDate().timeIntervalSinceDate(action.actStartDate))
                >= Float(Int(nowItem[0].procTime) * 60) {
                    
                    //スタート済のアクションが一定時間経っていたら終了させる.
                    //スタート時間 + 一定待機時間をエンド時間として算出する.
                    let calendar = NSCalendar.currentCalendar()
                    let comp = NSDateComponents()
                    comp.second = Int(nowItem[0].procTime) * 60
                    let willEndDate = calendar.dateByAddingComponents(comp, toDate: action.actStartDate, options: NSCalendarOptions())
                    
                    // 終了時間を更新する.
                    updateData.actEndDate = willEndDate
                    action.actEndDate = willEndDate

            }
            
            // データを更新する.
            updateData.managedObjectContext!.MR_saveToPersistentStoreAndWait()
            
            // アクションが実行中であった場合
            if action.actStartDate != nil && action.actEndDate == nil{
                
                // 実行中のアクションがあるということなので返却するアイテムIDをセットする.
                activeItemId = Int(action.itemID)
            }
            
            //１件目フラグをおろす.
            flgFirst = false
            
            //次のアクションのスタート時間設定用にエンド時間＋開始までのインターバル時間を退避しておく.
            if (action.actEndDate != nil) {
                let calendar = NSCalendar.currentCalendar()
                let comp = NSDateComponents()
                comp.second = 0
                willStartDate = calendar.dateByAddingComponents(comp, toDate: action.actEndDate, options: NSCalendarOptions())!
            }
        }
        
        // 実行中アクションのアイテムIDを返却する.
        return activeItemId
    }

    
    //ランダムウォーク
    func randomWalk() {

        //初期値
        var x: CGFloat = 0.0
        var y: CGFloat = 0.0
        var wkX: CGFloat
        var wkY: CGFloat
        let curX = self.myCharImageView.frame.origin.x
        let curY = self.myCharImageView.frame.origin.y
        var minX:CGFloat = CGFloat((Float(3)  / 10.0) * Float(self.view.bounds.width))
        var maxX:CGFloat = CGFloat((Float(8)  / 10.0) * Float(self.view.bounds.width))
        var minY:CGFloat = CGFloat((Float(6)  / 10.0) * Float(self.view.bounds.height))
        var maxY:CGFloat = CGFloat((Float(8)  / 10.0) * Float(self.view.bounds.height))

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
            
            // アクティブアイテムが存在する場合
            if activeItem.count > 0 {

                // 設定された可動範囲内のみでの動きとする.
                minX = CGFloat((Float(activeItem[0].minX) / 10.0) * Float(self.view.bounds.width))
                maxX = CGFloat((Float(activeItem[0].maxX) / 10.0) * Float(self.view.bounds.width))
                minY = CGFloat((Float(activeItem[0].minY) / 10.0) * Float(self.view.bounds.height))
                maxY = CGFloat((Float(activeItem[0].maxY) / 10.0) * Float(self.view.bounds.height))
            }
        
            //可動域の設定
            if CGFloat(minX) <= CGFloat(curX+wkX) && CGFloat(curX+wkX) <= CGFloat(maxX) &&
               CGFloat(minY) <= CGFloat(curY+wkY) && CGFloat(curY+wkY) <= CGFloat(maxY) {
                    x = wkX
                    y = wkY
            }

        } while (x == 0.0 && y == 0.0)

        // キャラクターアニメーションを設定する.
        var charaImages :[UIImage]? = []

        if curX == curX+x && curY <= curY+y {

            // 正面向き
            for actionImage in actionImages {
                
                print(actionImage.imageAct)
                
                if actionImage.way == 1 {
                    charaImages?.insert(Utility.getUncachedImage( named: String(actionImage.imageAct))!,atIndex: (charaImages?.count)!)
                }
            }            
        } else if curX == curX+x && curY > curY+y {

            // 後向き
            for actionImage in actionImages {
                
                print(actionImage.imageAct)
                
                if actionImage.way == 2 {
                    charaImages?.insert(Utility.getUncachedImage( named: String(actionImage.imageAct))!,atIndex: (charaImages?.count)!)
                }
            }
        } else if curX <= curX+x  {
            
            // 右向き
            for actionImage in actionImages {
                
                print(actionImage.imageAct)
                
                if actionImage.way == 3 {
                    charaImages?.insert(Utility.getUncachedImage( named: String(actionImage.imageAct))!,atIndex: (charaImages?.count)!)
                }
            }
        }else if curX > curX+x {
            
            // 左向き
            for actionImage in actionImages {
                
                print(actionImage.imageAct)
                
                if actionImage.way == 4 {
                    charaImages?.insert(Utility.getUncachedImage( named: String(actionImage.imageAct))!,atIndex: (charaImages?.count)!)
                }
            }
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
        animeTimer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: "randomWalk", userInfo: nil, repeats: true)
    }

    //定点キョロキョロ
    func teitenKyoroKyoro() {

        // キャラクターアニメーションを設定する.
        var charaImages :[UIImage]? = []

        for actionImage in actionImages {
           charaImages?.append(Utility.getUncachedImage( named: String(actionImage.imageAct))!)
        }

        self.myCharImageView.animationImages = charaImages
        self.myCharImageView.animationDuration = 3
        self.myCharImageView.startAnimating()
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
                multiplier: 1.0 / 1.04,
                constant: 0
            ),

            // y座標
            NSLayoutConstraint(
                item: self.manuBtn,
                attribute: NSLayoutAttribute.Bottom,
                relatedBy: .Equal,
                toItem: self.footerBaner,
                attribute:  NSLayoutAttribute.Top,
                multiplier: 1.0 / 1.02,
                constant: 0
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
                multiplier: 1.0 / 1.04,
                constant: 0
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
                multiplier: 1.0 / 1.04,
                constant: 0
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
                multiplier: 1.0 / 1.04,
                constant: 0
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
                multiplier: 1.0 / 1.1,
                constant: 0
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
}

