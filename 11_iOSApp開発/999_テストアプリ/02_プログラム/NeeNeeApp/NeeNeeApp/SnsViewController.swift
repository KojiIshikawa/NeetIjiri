//
//  SNSViewController.swift
//  NeeNeeApp
//
//  Created by Boil Project on 2016/02/11.
//  Copyright © 2016年 Boil Project. All rights reserved.
//

import Foundation
import Social

//SNS画面です。
class SnsViewController: UIViewController {

    
    // シェアメニューのオブジェクト
    private var shareImgView: UIImageView!

    // オブジェクト
    private var facebookBtn: UIButton!
    private var lineBtn: UIButton!
    private var twitterBtn: UIButton!
    private var questionBtn: UIButton!
    private var kakugen = ""
    
    // view アンロード開始時
    override func viewWillDisappear(animated: Bool) {
        
        // SEを再生する.
        Utility.seSoundPlay(Const.SE_NO_PATH)
    }
    
    // view ロード完了時
    override func viewDidLoad() {
        print(NSDate().description, NSStringFromClass(self.classForCoder), __FUNCTION__, __LINE__)
        super.viewDidLoad()

        //セッション情報.
        let ud = NSUserDefaults.standardUserDefaults()
        let udDateKkgnLst: Int! = ud.integerForKey("KAKUGEN_LAST_DATE")
        let udKakugenId: Int! = ud.integerForKey("KAKUGEN_ID")
        
        //NSCalendarインスタンス
        let cal = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
        let now = NSDate()
        let year = cal.component(NSCalendarUnit.Year , fromDate: now) * 10000
        let Month = cal.component(NSCalendarUnit.Month , fromDate: now) * 100
        let day = cal.component(NSCalendarUnit.Day , fromDate: now)
        var kakugenList :[M_Kakugen]
        
        //前回表示時と同じ年月日の場合
        if udDateKkgnLst == year + Month + day {
            
            //格言をセッションから取得
            kakugenList = M_Kakugen.MR_findByAttribute("kakugenID", withValue:udKakugenId , andOrderBy: "kakugenID", ascending: true) as! [M_Kakugen];
            kakugen = kakugenList[0].kakugenText
        }
        
        //背景生成
        shareImgView = UIImageView(frame: self.view.frame)
        shareImgView.image = Utility.getUncachedImage(named: "02_02_01.png")
        
        // FaceBookボタンを生成
        facebookBtn = UIButton()
        let facebookImage = Utility.getUncachedImage( named: "01_07_01.png")! as UIImage
        facebookBtn.setImage(facebookImage, forState: .Normal)
        facebookBtn.addTarget(self, action: "tapFacebookBtn:", forControlEvents: .TouchUpInside)
        
        // Twitterボタンを生成
        twitterBtn = UIButton()
        let twitterImage = Utility.getUncachedImage( named: "01_08_01.png")! as UIImage
        twitterBtn.setImage(twitterImage, forState: .Normal)
        twitterBtn.addTarget(self, action: "tapTwitterBtn:", forControlEvents: .TouchUpInside)
        
        // LINEボタンを生成
        lineBtn = UIButton()
        let lineImage = Utility.getUncachedImage( named: "01_09_01.png")! as UIImage
        lineBtn.setImage(lineImage, forState: .Normal)
        lineBtn.addTarget(self, action: "tapLineBtn:", forControlEvents: .TouchUpInside)

        // ？ボタンを生成
        questionBtn = UIButton()
        let questionImage = Utility.getUncachedImage( named: "01_12_01.png")! as UIImage
        questionBtn.setImage(questionImage, forState: .Normal)
        questionBtn.addTarget(self, action: "tapQuestionBtn:", forControlEvents: .TouchUpInside)
        
        // ポップ上に表示するオブジェクトをViewに追加する.
        self.view.addSubview(shareImgView)
        self.view.addSubview(facebookBtn)
        self.view.addSubview(twitterBtn)
        self.view.addSubview(lineBtn)
        self.view.addSubview(questionBtn)
        
        // オブジェクトの制約の設定
        self.objConstraints()
    }
    
    //メモリ消費が多くなった時に動くイベント
    override func didReceiveMemoryWarning() {
        print(NSDate().description, NSStringFromClass(self.classForCoder), __FUNCTION__, __LINE__)
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //facebookボタン押下時の処理
    func tapFacebookBtn(sender: AnyObject) {
        print(NSDate().description, NSStringFromClass(self.classForCoder), __FUNCTION__, __LINE__)
        
        // SEを再生する.
        Utility.seSoundPlay(Const.SE_YES_PATH)
        
        // Facebookの投稿ダイアログを作って
        let cv = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        
        // 画像を追加
        cv.addImage(UIImage(named: "01_13_01.png"))
        
        // 文字を追加
        cv.setInitialText(Const.SNS_MASSAGE + kakugen)
        
        // 投稿ダイアログを表示する
        self.presentViewController(cv, animated: true, completion: nil)
    }
    
    //ラインボタン押下時の処理
    func tapLineBtn(sender: AnyObject) {
        print(NSDate().description, NSStringFromClass(self.classForCoder), __FUNCTION__, __LINE__)
        
        // SEを再生する.
        Utility.seSoundPlay(Const.SE_YES_PATH)
        
        //　共有する項目
        let shareImage = UIImage(named: "01_13_01.png")!
        let shareItems = [shareImage]
        
        // LINEで送るボタンを追加
        let line = LINEActivity()
        let avc = UIActivityViewController(activityItems: shareItems, applicationActivities: [line])
        
        // 投稿ダイアログを表示する
        presentViewController(avc, animated: true, completion: nil)
    }
    
    //Twitterボタン押下時の処理
    func tapTwitterBtn(sender: AnyObject) {
        print(NSDate().description, NSStringFromClass(self.classForCoder), __FUNCTION__, __LINE__)
        
        // SEを再生する.
        Utility.seSoundPlay(Const.SE_YES_PATH)
        
        // 共有する項目
        // Twitterの投稿ダイアログを作って
        let cv = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        
        // 画像を追加
        cv.addImage(UIImage(named: "01_13_01.png"))
        
        // 文字を追加
        cv.setInitialText(Const.SNS_MASSAGE + kakugen)
        
        // 投稿ダイアログを表示する
        self.presentViewController(cv, animated: true, completion:nil )
    }

    //？ボタン押下時の処理
    func tapQuestionBtn(sender: AnyObject) {
        print(NSDate().description, NSStringFromClass(self.classForCoder), __FUNCTION__, __LINE__)
        
        // SEを再生する.
        Utility.seSoundPlay(Const.SE_NO_PATH)
    }
    
    /** 全オブジェクトの制約設定 **/
    func objConstraints() {
        print(NSDate().description, NSStringFromClass(self.classForCoder), __FUNCTION__, __LINE__)
        
        shareImgView.translatesAutoresizingMaskIntoConstraints = false
        facebookBtn.translatesAutoresizingMaskIntoConstraints = false
        twitterBtn.translatesAutoresizingMaskIntoConstraints = false
        lineBtn.translatesAutoresizingMaskIntoConstraints = false
        questionBtn.translatesAutoresizingMaskIntoConstraints = false
        
        // 壁紙の制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.shareImgView,
                attribute:  NSLayoutAttribute.Right,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.Right,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.shareImgView,
                attribute: NSLayoutAttribute.Bottom,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.Bottom,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.shareImgView,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.shareImgView,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0,
                constant: 0
            )]
        )
        
        // facebookボタンの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.facebookBtn,
                attribute:  NSLayoutAttribute.Left,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.Right,
                multiplier: 1.0 / 8.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.facebookBtn,
                attribute: NSLayoutAttribute.Top,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 100
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.facebookBtn,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0 / 3.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.facebookBtn,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0 / 4.0,
                constant: 0
            )]
        )
        
        // twitterボタンの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.twitterBtn,
                attribute:  NSLayoutAttribute.Left,
                relatedBy: .Equal,
                toItem: self.facebookBtn,
                attribute:  NSLayoutAttribute.Right,
                multiplier: 1.2 / 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.twitterBtn,
                attribute: NSLayoutAttribute.Top,
                relatedBy: .Equal,
                toItem: self.facebookBtn,
                attribute:  NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.twitterBtn,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0 / 3.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.twitterBtn,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0 / 4.0,
                constant: 0
            )]
        )
        
        // lineボタンの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.lineBtn,
                attribute:  NSLayoutAttribute.Left,
                relatedBy: .Equal,
                toItem: self.facebookBtn,
                attribute:  NSLayoutAttribute.Left,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.lineBtn,
                attribute: NSLayoutAttribute.Top,
                relatedBy: .Equal,
                toItem: self.facebookBtn,
                attribute:  NSLayoutAttribute.Bottom,
                multiplier: 1.2 / 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.lineBtn,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0 / 3.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.lineBtn,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0 / 4.0,
                constant: 0
            )]
        )
        
        // ？ボタンの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.questionBtn,
                attribute:  NSLayoutAttribute.Left,
                relatedBy: .Equal,
                toItem: self.twitterBtn,
                attribute:  NSLayoutAttribute.Left,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.questionBtn,
                attribute: NSLayoutAttribute.Top,
                relatedBy: .Equal,
                toItem: self.lineBtn,
                attribute:  NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.questionBtn,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0 / 3.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.questionBtn,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0 / 4.0,
                constant: 0
            )]
        )
        
    }
}
