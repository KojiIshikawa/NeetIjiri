//
//  NeetMainViewController.swift
//  NeeNeeApp
//
//  Created by Boil Project on 2015/12/27.
//  Copyright © 2015年 Boil Project. All rights reserved.
//

import UIKit
import AVFoundation

class NeetMainViewController: UIViewController, AVAudioPlayerDelegate,UICollectionViewDelegate,
                                UIGestureRecognizerDelegate,UIPopoverPresentationControllerDelegate, NADViewDelegate {

    
    //****************************************
    // MARK: - メンバ変数
    //****************************************
    
    // バナー
    fileprivate var nadView: NADView!
    
    // メニューボタン制御用
    fileprivate var manuBtnFlg = true
    
    // 壁紙オブジェクト
    fileprivate var myImageView: UIImageView!
    
    // キャラクターオブジェクト
    fileprivate var myCharImageView: UIImageView!

    // メニューボタン
    fileprivate var manuBtn: UIButton!
    fileprivate var mainBtn: UIButton!
    fileprivate var shareBtn: UIButton!
    fileprivate var detailBtn: UIButton!
    fileprivate var configBtn: UIButton!

    //アニメーションタイマー
    fileprivate var animeTimer: Timer!

    //アクティブアイテム
    fileprivate var activeItem: [M_Item]!
    
    //キャラクターイメージ
    fileprivate var actionImages:[M_ActionImage]!
    
    //初回表示判定フラグ
    fileprivate var isFirstLoad: Bool! = false
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }
    
    //****************************************
    // MARK: - イベント
    //****************************************
    
    // view 初回ロード時
    override func viewDidLoad() {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        super.viewDidLoad()

        //アクティブ時のイベントを受け取る.
        NotificationCenter.default.addObserver(self, selector: #selector(NeetMainViewController.enterForeground(_:)), name:NSNotification.Name(rawValue: "applicationWillEnterForeground"), object: nil)

        //非アクティブ時のイベントを受け取る.
        NotificationCenter.default.addObserver(self, selector: #selector(NeetMainViewController.enterBackground(_:)), name:NSNotification.Name(rawValue: "applicationDidEnterBackground"), object: nil)
        
        //オブジェクトの配置
        self.createObjInit()
        
        // オブジェクトの制約の設定
        self.objConstraints()
        
        // ログインボーナス表示可能
        self.isFirstLoad = true
    }
    

    //view 表示完了後 毎回呼ばれる
    override func viewDidAppear(_ animated: Bool) {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)

        super.viewDidAppear(false)

        //ログインボーナス画面の表示
        if (self.isFirstLoad == true) {
            self.showLoginBonus()
            self.isFirstLoad = false
        }
    }
    
    //メモリ消費が多くなった時に動くイベント
    override func didReceiveMemoryWarning() {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //アクティブ時に動くイベント
    func enterForeground(_ notification: Notification){
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        
        // オブジェクト変数を初期化する.
        self.activeItem.removeAll()
        self.actionImages.removeAll()
        self.myCharImageView.removeFromSuperview()
        self.manuBtn.removeFromSuperview()
        self.mainBtn.removeFromSuperview()
        self.shareBtn.removeFromSuperview()
        self.detailBtn.removeFromSuperview()
        self.configBtn.removeFromSuperview()
        self.myImageView.removeFromSuperview()
        
        // アクション進捗の最新化＆再描画する.
        self.manuBtnFlg = true
        
        //オブジェクトの配置
        self.createObjInit()
        
        // オブジェクトの制約の設定
        self.objConstraints()
        
        //ログインボーナス画面の表示
        Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(NeetMainViewController.showLoginBonus), userInfo: nil, repeats: false)
    }

    //非アクティブ時に動くイベント
    func enterBackground(_ notification: Notification){
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        
    }
    
    /** メニューボタン押下時の処理 **/
    func tapManuBtn(_ sender: AnyObject) {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        
        if  manuBtnFlg {
            
            // ボタンの文言を変える
            manuBtn.setImage(Utility.getUncachedImage(named: "01_02_01.png"),  for: UIControlState())
            manuBtnFlg = false
            
            // メニュー内ボタンの制御を切り替える.
            mainBtn.isHidden = false
            detailBtn.isHidden = false
            shareBtn.isHidden = false
            configBtn.isHidden = false

            // SEを再生する.
            Utility.seSoundPlay(Const.SE_YES_PATH)
            
        } else {
            
            // ボタンの文言を変える
            manuBtn.setImage(Utility.getUncachedImage(named: "01_01_01.png"),  for: UIControlState())
            manuBtnFlg = true
            
            // メニュー内ボタンの制御を切り替える.
            mainBtn.isHidden = true
            detailBtn.isHidden = true
            shareBtn.isHidden = true
            configBtn.isHidden = true
            
            // SEを再生する.
            Utility.seSoundPlay(Const.SE_NO_PATH)
        
        }
    }
    

    //Popover表示
    func showPopoverView(_ sender: AnyObject, identifier:String) {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        let popoverView = self.storyboard!.instantiateViewController(withIdentifier: identifier) as UIViewController
        popoverView.modalPresentationStyle = .popover
        popoverView.preferredContentSize = self.view.bounds.size
        popoverView.view.backgroundColor = UIColor.clear
        if let presentationController = popoverView.popoverPresentationController {
            presentationController.permittedArrowDirections = .down
            presentationController.sourceView = sender as! UIButton
            presentationController.sourceRect = sender.bounds
            presentationController.delegate = self
            presentationController.popoverBackgroundViewClass = PopoverBackgroundView.classForCoder()!
        }
        popoverView.title = identifier
        self.present(popoverView, animated: true, completion: nil)
    
    }
    
    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
    }
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        return true
    }
    
    //popOver表示終了後のイベント
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        let identifier = popoverPresentationController.presentedViewController.title
        
        //ログイン画面または結果表示画面からの戻りの場合
        if (identifier == "LoginBonusView" || identifier == "ResultView") {

            //未完了の行動済行動履歴を取得し、存在する場合は結果画面を表示する.
            if (Utility.getFinishedTActionResult(Const.CHARACTER1_ID).count > 0) {
                
                // SEを再生する.
                Utility.seSoundPlay(Const.SE_RESULT_PATH)
                
                self.showPopoverView(self.manuBtn, identifier: "ResultView")
                
            } else {
                
                // インターステイシャル広告を表示する.
                NADInterstitial.sharedInstance().showAd()
            }
        }
        
        //格言画面からの戻りの場合
        if identifier == "KakugenView" {
            
            // インターステイシャル広告を表示する.
            NADInterstitial.sharedInstance().showAd()
        }
    }
    
    //Popover実装時に必要になるイベント　おまじない
    func adaptivePresentationStyle(for controller: UIPresentationController)
        -> UIModalPresentationStyle {
            return .none
    }
    
    
    
    /** ひまつぶしボタン押下時の処理 **/
    func tapMainBtn(_ sender: AnyObject) {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        
        // SEを再生する.
        Utility.seSoundPlay(Const.SE_YES_PATH)
        
        //PopOverを表示
        self.showPopoverView(sender, identifier: "ActionSetView")
        
    }

    //詳細ボタン押下時
    func tapDetailBtn(_ sender: AnyObject) {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)

        // SEを再生する.
        Utility.seSoundPlay(Const.SE_YES_PATH)
        
        //PopOverを表示
        self.showPopoverView(sender, identifier: "ProfileView")
        
    }
    
    /** シェアボタン押下時の処理 **/
    func tapShareBtn(_ sender: AnyObject) {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        
        // SEを再生する.
        Utility.seSoundPlay(Const.SE_YES_PATH)
        
        //PopOverを表示
        self.showPopoverView(sender, identifier: "SnsView")
        
    }

    /** 設定ボタン押下時の処理 **/
    func tapConfigBtn(_ sender: AnyObject) {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        
        // SEを再生する.
        Utility.seSoundPlay(Const.SE_YES_PATH)
        
        //PopOverを表示
        self.showPopoverView(sender, identifier: "SettingView")
        
    }
    
    // ジェスチャーイベント処理
    func tapChara(_ gestureRecognizer: UITapGestureRecognizer){
        
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        
        //年月日を取得する.
        //NSCalendarインスタンス
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let now = Date()
        let year = (cal as NSCalendar).component(NSCalendar.Unit.year , from: now) * 10000
        let Month = (cal as NSCalendar).component(NSCalendar.Unit.month , from: now) * 100
        let day = (cal as NSCalendar).component(NSCalendar.Unit.day , from: now)
        let ud = UserDefaults.standard
        let udDateKkgnLst: Int! = ud.integer(forKey: "KAKUGEN_LAST_DATE")
        var dispKakugen = false
        
        //前回表示時と同じ年月日の場合
        if udDateKkgnLst == year + Month + day {
            
            //SEを再生する.
            Utility.seSoundPlay(Const.SE_KAKUGEN_PATH)
            
            self.showPopoverView(self.manuBtn, identifier: "KakugenView")
            
            //格言表示フラグをオン
            dispKakugen = true
            
        } else {
            
            let alertController = UIAlertController(title: "きょうの格言", message: "きょうの格言をみますか？", preferredStyle: .alert)
            
            let defaultActionYes = UIAlertAction(title: "みる", style: .default, handler:{
                (action:UIAlertAction!) -> Void in
                
                //格言表示フラグをオン
                dispKakugen = true
                
                //SEを再生する.
                Utility.seSoundPlay(Const.SE_KAKUGEN_PATH)
                
                //格言表示
                self.showPopoverView(self.manuBtn, identifier: "KakugenView")
                
                //NSUserDefaultに格言表示日付をセット
                let ud = UserDefaults.standard
                
                //年月日を取得し、セッションに格納
                ud.set(year + Month + day, forKey: "KAKUGEN_LAST_DATE")
                ud.synchronize()

            })
            alertController.addAction(defaultActionYes)
            
            let defaultActionNo = UIAlertAction(title: "みない", style: .default, handler: nil)
            alertController.addAction(defaultActionNo)

            // アラート表示
            present(alertController, animated: true, completion:nil)
            
        }

        // 画面を表示
        if dispKakugen {
            self.showPopoverView(self.manuBtn, identifier: "KakugenView")
        }

    }
    
    //****************************************
    // MARK: - その他メソッド
    //****************************************

    //ログインボーナス
    func showLoginBonus() {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        
        //セッション情報.
        let ud = UserDefaults.standard
        let udDateLoginLst: Int! = ud.integer(forKey: "LOGIN_LAST_DATE")
        
        //NSCalendarインスタンス
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let now = Date()
        let year = (cal as NSCalendar).component(NSCalendar.Unit.year , from: now) * 10000
        let Month = (cal as NSCalendar).component(NSCalendar.Unit.month , from: now) * 100
        let day = (cal as NSCalendar).component(NSCalendar.Unit.day , from: now)
        
        print(year + Month + day)
        
        //前回表示時と同じ年月日の場合
        if udDateLoginLst == year + Month + day {

            //行動結果PopOverを表示（表示すべきものがある場合のみ）
            //未完了の行動済行動履歴を取得し、存在する場合は結果画面を表示する.
            if (Utility.getFinishedTActionResult(Const.CHARACTER1_ID).count > 0) {
                
                // SEを再生する.
                Utility.seSoundPlay(Const.SE_RESULT_PATH)
                
                self.showPopoverView(self.manuBtn, identifier: "ResultView")
            }

        } else {

            //前回のログイン時と日付が異なる場合
            // SEを再生する.
            Utility.seSoundPlay(Const.SE_LOGIN_PATH)
            
            //ログインボーナスPopOverを表示
            self.showPopoverView(self.manuBtn, identifier: "LoginBonusView")
            
            //ログイン年月日をセッションに格納
            ud.set(year + Month + day, forKey: "LOGIN_LAST_DATE")
            ud.synchronize()
        }
    }
    
    //背景を取得
    func getBackGroundImage(_ _strImageFileName:String) ->UIImage {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        var imageBack = ""
        
        //現在行動中であれば、そのステージの背景を設定
        //行動中でなければ、デフォルトステージを設定
        if _strImageFileName > "" {

            imageBack = _strImageFileName
            
        } else {

            let stage = M_Stage.mr_findFirst(byAttribute: "stageID", withValue: 1)! as M_Stage
            imageBack = stage.imageBack
        }
        
        return Utility.getUncachedImage(named: imageBack)!
            
    }
    
    
    //初期表示時のオブジェクトを作成し設置する
    func createObjInit() {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)

        let activeItemId = self.updateSetAction()
        activeItem = Utility.getMItem(activeItemId)
        var activeStage = [M_Stage]()
        
        if activeItem.count >= 1 {
            activeStage = Utility.getMStage(Int(activeItem[0].stageID))
            actionImages = Utility.getMActionImage(Int(activeItem[0].itemID))
            
        } else {
            
            // ない場合は先頭のデータを取得する.
            activeItem = Utility.getMItem(0)
            actionImages = Utility.getMActionImage(0)
            activeStage = Utility.getMStage(1)
        }
        
        // 背景設定
        myImageView = UIImageView()
        myImageView.frame.size = CGSize(width: self.view.bounds.width, height: self.view.bounds.height)
        myImageView.image = self.getBackGroundImage(activeStage.count >= 1 ? activeStage[0].imageBack : "")
        self.view.addSubview(myImageView)
        
        //キャラクター設定
        // UIImageViewをViewに追加する.
        myCharImageView = UIImageView()
        
        //キャラクターサイズの倍率を取得する.
        let charaSizeRate : CGFloat = (activeItem.count >= 1 ? CGFloat(activeItem[0].useArea) : CGFloat(Const.CHARACTER_DEFAULT_SIZE_RATE)) / 10
        
        //キャラクターサイズ設定.
        myCharImageView.frame.size = CGSize(
            width: (self.view.bounds.width  / 2.6) * charaSizeRate
           ,height: (self.view.bounds.height / 3.0) * charaSizeRate)
        
        //キャラクター初期横位置設定.
        myCharImageView.frame.origin.x = CGFloat(Float(self.view.bounds.width)
                                 * (Float(activeItem.count >= 1 ? activeItem[0].firstX : Const.CHARACTER_DEFAULT_FIRST_X) / 100))
        //キャラクター初期縦位置設定.
        myCharImageView.frame.origin.y = CGFloat(Float(self.view.bounds.height)
                                 * (Float(activeItem.count >= 1 ? activeItem[0].firstY : Const.CHARACTER_DEFAULT_FIRST_Y) / 100))

        myCharImageView.tag = 1
        myCharImageView.isUserInteractionEnabled = true
        let singleTap = UITapGestureRecognizer(target: self, action:#selector(NeetMainViewController.tapChara(_:)))
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
        
        // NADViewクラスを生成
        nadView = NADView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        nadView.frame.origin.x = (self.view.bounds.width - nadView.frame.width) * 0.5
        nadView.frame.origin.y = self.view.bounds.height - nadView.frame.height
        
        // 広告枠のapikey/spotidを設定(必須)
        nadView.setNendID("ccdc50cb50ce600fb0597b861ac01069ebdfaea3",
                          spotID: "631007")
        
        // nendSDKログ出力の設定(任意)
        nadView.isOutputLog = false
        
        // delegateを受けるオブジェクトを指定(必須)
        nadView.delegate = self
        
        // 読み込み開始(必須)
        nadView.load()
        
        // メニューボタン及びサブメニューボタンの設定.
        manuBtn = UIButton()
        manuBtn.setTitle("MENU",  for: UIControlState())
        manuBtn.setImage(Utility.getUncachedImage(named: "01_01_01.png"), for: UIControlState())
        manuBtn.addTarget(self, action: #selector(NeetMainViewController.tapManuBtn(_:)), for: .touchUpInside)
        manuBtn.sizeToFit()
        self.view.addSubview(manuBtn)
        
        //暇つぶしボタン
        mainBtn = UIButton()
        mainBtn.setImage(Utility.getUncachedImage(named: "01_03_01.png"), for: UIControlState())
        mainBtn.addTarget(self, action: #selector(NeetMainViewController.tapMainBtn(_:)), for: .touchUpInside)
        manuBtn.sizeToFit()
        self.view.addSubview(mainBtn)
        
        //履歴書ボタン
        detailBtn = UIButton()
        detailBtn.setImage(Utility.getUncachedImage(named: "01_04_01.png"), for: UIControlState())
        detailBtn.addTarget(self, action: #selector(NeetMainViewController.tapDetailBtn(_:)), for: .touchUpInside)
        detailBtn.sizeToFit()
        self.view.addSubview(detailBtn)
        
        //共有ボタン
        shareBtn = UIButton()
        shareBtn.setImage(Utility.getUncachedImage(named: "01_05_01.png"), for: UIControlState())
        shareBtn.addTarget(self, action: #selector(NeetMainViewController.tapShareBtn(_:)), for: .touchUpInside)
        shareBtn.sizeToFit()
        self.view.addSubview(shareBtn)
        
        //設定ボタン
        configBtn = UIButton()
        configBtn.setImage(Utility.getUncachedImage(named: "01_06_01.png"), for: UIControlState())
        configBtn.addTarget(self, action: #selector(NeetMainViewController.tapConfigBtn(_:)), for: .touchUpInside)
        configBtn.sizeToFit()
        self.view.addSubview(configBtn)
        
        // メニューボタン以外のボタンを非表示にする
        mainBtn.isHidden = true
        detailBtn.isHidden = true
        shareBtn.isHidden = true
        configBtn.isHidden = true
        
        // テーマソングを再生する.
        Utility.bgmSoundPlay(activeStage.count >= 1 ? activeStage[0].bgm : "")
    }
    
    //ニートを動かすアニメーション
    func animationStart() {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        animeTimer = Timer.scheduledTimer(timeInterval: 0.0, target: self, selector: #selector(NeetMainViewController.randomWalk), userInfo: nil, repeats: true)
    }
    
    /** セットアクション情報の更新 **/
    func updateSetAction() -> Int {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
 
        // 更新対象のアクション（最大３件）を取得する.
        let actionFilter: NSPredicate =
        NSPredicate(format: "charaID = " + String(Const.CHARACTER1_ID) + " and actEndDate = null");
        let actionList :[T_ActionResult] = T_ActionResult.mr_findAllSorted(by: "actSetDate,actStartDate", ascending: true, with: actionFilter) as! [T_ActionResult];

        // 完了済のアクションの最新１件を取得する.
        let oldActionFilter: NSPredicate =
        NSPredicate(format: "charaID = " + String(Const.CHARACTER1_ID) + " and actEndDate <> null");
        let oldActionList :[T_ActionResult] = T_ActionResult.mr_findAllSorted(by: "actEndDate", ascending: false, with: oldActionFilter) as! [T_ActionResult];
        
        var activeItemId = -1
        var flgFirst = true
        var willStartDate: Date = Date()
        
        for action in actionList {
            
            // アクティブなアイテムが探知済の場合、それ以降のアイテムは処理しない.
            if activeItemId != -1 {
                break;
            }
            
            // 処理対象アクションのアイテム情報を取得する.
            let nowItem = Utility.getMItem(Int(action.itemID))
            
            // １件目の場合、スタート時間にセット時間＋開始までのインターバル時間(3分)を設定しておく.
            if flgFirst {

                let calendar = Calendar.current
                var comp = DateComponents()
                comp.second = Int(Const.ACTION_START_TIME_INTERVAL)
                
                // 前回のアクションが存在する場合は、１件目アクションのセット時間と
                // 前回アクションの終了時間を比較し、新しい方をスタート時間として採用する.
                if oldActionList.count > 0 &&
                    Float(oldActionList[0].actEndDate.timeIntervalSince(action.actSetDate))
                    >= Float(0.0) {

                    willStartDate = (calendar as NSCalendar).date(
                        byAdding: comp
                      , to:oldActionList[0].actEndDate
                      , options: NSCalendar.Options())!
                        
                } else {

                    willStartDate = (calendar as NSCalendar).date(
                        byAdding: comp
                      , to: action.actSetDate
                      , options: NSCalendar.Options())!
                }
                
            }

            
            //スタート時間を、算出した時間で更新する.
            let updPredicate: NSPredicate = NSPredicate(
                format: "charaID = %@ AND itemID = %@ AND actSetDate = %@"
                , argumentArray:[action.charaID,String(describing: action.itemID), action.actSetDate]);
            
            let updateData = T_ActionResult.mr_findFirst(with: updPredicate)! as T_ActionResult

            
            // スタート時間の更新
            // スタート時間が未設定かつ、インターバル時間を経過している場合
            if action.actStartDate == nil
                && Float(Date().timeIntervalSince(willStartDate)) >= Float(0.0) {
                    
                    // 開始時間を更新する.
                    updateData.actStartDate = willStartDate
                    action.actStartDate = willStartDate
            }
            
            // スタート済のアクションが一定時間経過していたら、さらにエンド時間をセットさせ終了させる.
            if action.actStartDate != nil &&
                Float(Date().timeIntervalSince(action.actStartDate))
                >= Float(Int(nowItem[0].procTime) * 60) {
                    
                    //スタート済のアクションが一定時間経っていたら終了させる.
                    //スタート時間 + 一定待機時間をエンド時間として算出する.
                    let calendar = Calendar.current
                    var comp = DateComponents()
                    comp.second = Int(nowItem[0].procTime) * 60
                    let willEndDate = (calendar as NSCalendar).date(byAdding: comp, to: action.actStartDate, options: NSCalendar.Options())
                    
                    // 終了時間を更新する.
                    updateData.actEndDate = willEndDate
                    action.actEndDate = willEndDate
                    
                    // 所持ステージに書き込む.
                    Utility.editT_RefStage(Int(nowItem[0].stageID))
                    
                    // 所持役職に書き込む.
                    Utility.editT_RefJob(Int(nowItem[0].stageID))

            }
            
            // データを更新する.
            updateData.managedObjectContext!.mr_saveToPersistentStoreAndWait()
            
            // アクションが実行中であった場合
            if action.actStartDate != nil && action.actEndDate == nil{
                
                // 実行中のアクションがあるということなので返却するアイテムIDをセットする.
                activeItemId = Int(action.itemID)
            }
            
            //１件目フラグをおろす.
            flgFirst = false
            
            //次のアクションのスタート時間設定用にエンド時間＋開始までのインターバル時間を退避しておく.
            if (action.actEndDate != nil) {
                let calendar = Calendar.current
                var comp = DateComponents()
                comp.second = 0
                willStartDate = (calendar as NSCalendar).date(byAdding: comp, to: action.actEndDate, options: NSCalendar.Options())!
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
        var minX:CGFloat = CGFloat(0.3 * Float(self.view.bounds.width))
        var maxX:CGFloat = CGFloat(0.8 * Float(self.view.bounds.width))
        var minY:CGFloat = CGFloat(0.6 * Float(self.view.bounds.height))
        var maxY:CGFloat = CGFloat(0.8 * Float(self.view.bounds.height))
        let curX = self.myCharImageView.frame.origin.x
        let curY = self.myCharImageView.frame.origin.y
        let moveSize:CGFloat = CGFloat(0.14 * Float(self.view.bounds.width))
        
        //動く方向を決める(8方向)
        repeat {
            wkX = 0.0
            wkY = 0.0
        
            let indexX = Int(arc4random_uniform(3))
            switch indexX {
            case 0:
                wkX = -1 * moveSize
            case 1:
                wkX = moveSize
            default:
                wkX = 0.0
            }
        
            let indexY = Int(arc4random_uniform(3))
            switch indexY {
            case 0:
                wkY = -1 * moveSize
            case 1:
                wkY = moveSize
            default:
                wkY = 0.0
            }
            
            // アクティブアイテムが存在する場合
            if activeItem.count > 0 {

                // 設定された可動範囲内のみでの動きとする.
                minX = CGFloat((Float(activeItem[0].minX) / 100.0) * Float(self.view.bounds.width))
                maxX = CGFloat((Float(activeItem[0].maxX) / 100.0) * Float(self.view.bounds.width))
                minY = CGFloat((Float(activeItem[0].minY) / 100.0) * Float(self.view.bounds.height))
                maxY = CGFloat((Float(activeItem[0].maxY) / 100.0) * Float(self.view.bounds.height))
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
                    charaImages?.insert(Utility.getUncachedImage( named: String(actionImage.imageAct))!,at: (charaImages?.count)!)
                }
            }            
        } else if curX == curX+x && curY > curY+y {

            // 後向き
            for actionImage in actionImages {
                
                print(actionImage.imageAct)
                
                if actionImage.way == 2 {
                    charaImages?.insert(Utility.getUncachedImage( named: String(actionImage.imageAct))!,at: (charaImages?.count)!)
                }
            }
        } else if curX <= curX+x  {
            
            // 右向き
            for actionImage in actionImages {
                
                print(actionImage.imageAct)
                
                if actionImage.way == 3 {
                    charaImages?.insert(Utility.getUncachedImage( named: String(actionImage.imageAct))!,at: (charaImages?.count)!)
                }
            }
        }else if curX > curX+x {
            
            // 左向き
            for actionImage in actionImages {
                
                print(actionImage.imageAct)
                
                if actionImage.way == 4 {
                    charaImages?.insert(Utility.getUncachedImage( named: String(actionImage.imageAct))!,at: (charaImages?.count)!)
                }
            }
        }
        
        self.myCharImageView.animationImages = charaImages
        self.myCharImageView.animationDuration = 3
        self.myCharImageView.startAnimating()
        
        // 移動
        UIView.animate(
            withDuration: 2.0, // アニメーションの時間
            delay:0.0,
            options:[UIViewAnimationOptions.transitionCrossDissolve
                ,UIViewAnimationOptions.allowUserInteraction],
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
        animeTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(NeetMainViewController.randomWalk), userInfo: nil, repeats: true)
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
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
   
        manuBtn.translatesAutoresizingMaskIntoConstraints = false
        configBtn.translatesAutoresizingMaskIntoConstraints = false
        shareBtn.translatesAutoresizingMaskIntoConstraints = false
        detailBtn.translatesAutoresizingMaskIntoConstraints = false
        mainBtn.translatesAutoresizingMaskIntoConstraints = false
        
        // メニューボタンの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.manuBtn,
                attribute:  NSLayoutAttribute.right,
                relatedBy: .equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.right,
                multiplier: 1.0 / 1.04,
                constant: 0
            ),

            // y座標
            NSLayoutConstraint(
                item: self.manuBtn,
                attribute: NSLayoutAttribute.bottom,
                relatedBy: .equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.bottom,
                multiplier: 1.0 / getMenuBtnY(),
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.manuBtn,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .width,
                multiplier: 1.0 / 6.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.manuBtn,
                attribute: .height,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .height,
                multiplier: 1.0 / 12.0,
                constant: 0
            )]
        )
        
        // 設定ボタンの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.configBtn,
                attribute:  NSLayoutAttribute.right,
                relatedBy: .equal,
                toItem: self.manuBtn,
                attribute:  NSLayoutAttribute.left,
                multiplier: 1.0 / 1.04,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.configBtn,
                attribute: NSLayoutAttribute.top,
                relatedBy: .equal,
                toItem: self.manuBtn,
                attribute:  NSLayoutAttribute.top,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.configBtn,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.manuBtn,
                attribute: .width,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.configBtn,
                attribute: .height,
                relatedBy: .equal,
                toItem: self.manuBtn,
                attribute: .height,
                multiplier: 1.0,
                constant: 0
            )]
        )
        
        // 履歴書ボタンの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.detailBtn,
                attribute:  NSLayoutAttribute.right,
                relatedBy: .equal,
                toItem: self.shareBtn,
                attribute:  NSLayoutAttribute.left,
                multiplier: 1.0 / 1.04,
                constant: 0
            ),
            
            
            // y座標
            NSLayoutConstraint(
                item: self.detailBtn,
                attribute: NSLayoutAttribute.top,
                relatedBy: .equal,
                toItem: self.manuBtn,
                attribute:  NSLayoutAttribute.top,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.detailBtn,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.manuBtn,
                attribute: .width,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.detailBtn,
                attribute: .height,
                relatedBy: .equal,
                toItem: self.manuBtn,
                attribute: .height,
                multiplier: 1.0,
                constant: 0
            )]
        )
        
        // メインボタンの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.mainBtn,
                attribute:  NSLayoutAttribute.right,
                relatedBy: .equal,
                toItem: self.detailBtn,
                attribute:  NSLayoutAttribute.left,
                multiplier: 1.0 / 1.1,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.mainBtn,
                attribute: NSLayoutAttribute.top,
                relatedBy: .equal,
                toItem: self.manuBtn,
                attribute:  NSLayoutAttribute.top,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.mainBtn,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.manuBtn,
                attribute: .width,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.mainBtn,
                attribute: .height,
                relatedBy: .equal,
                toItem: self.manuBtn,
                attribute: .height,
                multiplier: 1.0,
                constant: 0
            )]
        )
        // シェアボタンの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.shareBtn,
                attribute:  NSLayoutAttribute.right,
                relatedBy: .equal,
                toItem: self.configBtn,
                attribute:  NSLayoutAttribute.left,
                multiplier: 1.0 / 1.04,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.shareBtn,
                attribute: NSLayoutAttribute.top,
                relatedBy: .equal,
                toItem: self.manuBtn,
                attribute:  NSLayoutAttribute.top,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.shareBtn,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.manuBtn,
                attribute: .width,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.shareBtn,
                attribute: .height,
                relatedBy: .equal,
                toItem: self.manuBtn,
                attribute: .height,
                multiplier: 1.0,
                constant: 0
            )]
        )
    }
    
    func nadViewDidFinishLoad(_ adView: NADView!) {
        print("delegate nadViewDidFinishLoad:")
        
        // ロードが完了してから NADView を表示する
        self.view.addSubview(nadView)
    }
    
    /** メニューボタンの相対的なY位置を端末によって分ける **/
    func getMenuBtnY() -> CGFloat {
        
        let screenSize = UIScreen.main.bounds
        let width = Int(screenSize.width)
        let height = Int(screenSize.height)
        
        switch width {
                
            case 320:
                
                if height == 480 {
                    //iPhone4
                    return 1.116
                } else {
                    //iPhone5
                    return 1.095
                }

            case 375:
                //iPhone6
                return 1.080
                
            default:
                //iPhone6 Plus及びその他
                return 1.072
        }
    }
    
}

