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
    fileprivate var shareImgView: UIImageView!

    // オブジェクト
    fileprivate var facebookBtn: UIButton!
    fileprivate var lineBtn: UIButton!
    fileprivate var twitterBtn: UIButton!
    fileprivate var questionBtn: UIButton!
    fileprivate var kakugen = ""
    
    // view アンロード開始時
    override func viewWillDisappear(_ animated: Bool) {
        
        // SEを再生する.
        Utility.seSoundPlay(Const.SE_NO_PATH)
    }
    
    // view ロード完了時
    override func viewDidLoad() {
        print(Date().description, NSStringFromClass(self.classForCoder), #function,#line)
        super.viewDidLoad()

        //セッション情報.
        let ud = UserDefaults.standard
        let udDateKkgnLst: Int! = ud.integer(forKey: "KAKUGEN_LAST_DATE")
        let udKakugenId: Int! = ud.integer(forKey: "KAKUGEN_ID")
        
        //NSCalendarインスタンス
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let now = Date()
        let year = (cal as NSCalendar).component(NSCalendar.Unit.year , from: now) * 10000
        let Month = (cal as NSCalendar).component(NSCalendar.Unit.month , from: now) * 100
        let day = (cal as NSCalendar).component(NSCalendar.Unit.day , from: now)
        var kakugenList :[M_Kakugen]
        
        //前回表示時と同じ年月日の場合
        if udDateKkgnLst == year + Month + day {
            
            //格言をセッションから取得
            kakugenList = M_Kakugen.mr_find(byAttribute: "kakugenID", withValue:udKakugenId , andOrderBy: "kakugenID", ascending: true) as! [M_Kakugen];
            kakugen = kakugenList[0].kakugenText
        }
        
        //背景生成
        shareImgView = UIImageView(frame: self.view.frame)
        shareImgView.image = Utility.getUncachedImage(named: "02_02_01.png")
        
        // FaceBookボタンを生成
        facebookBtn = UIButton()
        let facebookImage = Utility.getUncachedImage( named: "01_07_01.png")! as UIImage
        facebookBtn.setImage(facebookImage, for: UIControlState())
        facebookBtn.addTarget(self, action: #selector(SnsViewController.tapFacebookBtn(_:)), for: .touchUpInside)
        
        // Twitterボタンを生成
        twitterBtn = UIButton()
        let twitterImage = Utility.getUncachedImage( named: "01_08_01.png")! as UIImage
        twitterBtn.setImage(twitterImage, for: UIControlState())
        twitterBtn.addTarget(self, action: #selector(SnsViewController.tapTwitterBtn(_:)), for: .touchUpInside)
        
        // LINEボタンを生成
        lineBtn = UIButton()
        let lineImage = Utility.getUncachedImage( named: "01_09_01.png")! as UIImage
        lineBtn.setImage(lineImage, for: UIControlState())
        lineBtn.addTarget(self, action: #selector(SnsViewController.tapLineBtn(_:)), for: .touchUpInside)

        // ？ボタンを生成
        questionBtn = UIButton()
        let questionImage = Utility.getUncachedImage( named: "01_12_01.png")! as UIImage
        questionBtn.setImage(questionImage, for: UIControlState())
        questionBtn.addTarget(self, action: #selector(SnsViewController.tapQuestionBtn(_:)), for: .touchUpInside)
        
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
        print(Date().description, NSStringFromClass(self.classForCoder), #function,#line)
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //facebookボタン押下時の処理
    func tapFacebookBtn(_ sender: AnyObject) {
        print(Date().description, NSStringFromClass(self.classForCoder), #function,#line)
        
        // SEを再生する.
        Utility.seSoundPlay(Const.SE_YES_PATH)
        
        // Facebookの投稿ダイアログを作って
        let cv = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        
        // 画像を追加
        cv?.add(UIImage(named: "01_13_01.png"))
        
        // 文字を追加
        cv?.setInitialText(Const.SNS_MASSAGE + kakugen)
        
        // 投稿ダイアログを表示する
        self.present(cv!, animated: true, completion: nil)
    }
    
    //ラインボタン押下時の処理
    func tapLineBtn(_ sender: AnyObject) {
        print(Date().description, NSStringFromClass(self.classForCoder), #function,#line)
        
        // SEを再生する.
        Utility.seSoundPlay(Const.SE_YES_PATH)
        
        //　共有する項目
        let shareImage = UIImage(named: "01_13_01.png")!
        let shareItems = [shareImage]
        
        // LINEで送るボタンを追加
        let line = LINEActivity()
        let avc = UIActivityViewController(activityItems: shareItems, applicationActivities: [line!])
        
        // 投稿ダイアログを表示する
        present(avc, animated: true, completion: nil)
    }
    
    //Twitterボタン押下時の処理
    func tapTwitterBtn(_ sender: AnyObject) {
        print(Date().description, NSStringFromClass(self.classForCoder), #function,#line)
        
        // SEを再生する.
        Utility.seSoundPlay(Const.SE_YES_PATH)
        
        // 共有する項目
        // Twitterの投稿ダイアログを作って
        let cv = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        
        // 画像を追加
        cv?.add(UIImage(named: "01_13_01.png"))
        
        // 文字を追加
        cv?.setInitialText(Const.SNS_MASSAGE + kakugen)
        
        // 投稿ダイアログを表示する
        self.present(cv!, animated: true, completion:nil )
    }

    //？ボタン押下時の処理
    func tapQuestionBtn(_ sender: AnyObject) {
        print(Date().description, NSStringFromClass(self.classForCoder), #function,#line)
        
        // SEを再生する.
        Utility.seSoundPlay(Const.SE_NO_PATH)
    }
    
    /** 全オブジェクトの制約設定 **/
    func objConstraints() {
        print(Date().description, NSStringFromClass(self.classForCoder), #function,#line)
        
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
                attribute:  NSLayoutAttribute.right,
                relatedBy: .equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.right,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.shareImgView,
                attribute: NSLayoutAttribute.bottom,
                relatedBy: .equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.bottom,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.shareImgView,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .width,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.shareImgView,
                attribute: .height,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .height,
                multiplier: 1.0,
                constant: 0
            )]
        )
        
        // facebookボタンの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.facebookBtn,
                attribute:  NSLayoutAttribute.left,
                relatedBy: .equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.right,
                multiplier: 1.0 / 8.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.facebookBtn,
                attribute: NSLayoutAttribute.top,
                relatedBy: .equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.top,
                multiplier: 1.0,
                constant: 100
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.facebookBtn,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .width,
                multiplier: 1.0 / 3.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.facebookBtn,
                attribute: .height,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .height,
                multiplier: 1.0 / 4.0,
                constant: 0
            )]
        )
        
        // twitterボタンの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.twitterBtn,
                attribute:  NSLayoutAttribute.left,
                relatedBy: .equal,
                toItem: self.facebookBtn,
                attribute:  NSLayoutAttribute.right,
                multiplier: 1.2 / 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.twitterBtn,
                attribute: NSLayoutAttribute.top,
                relatedBy: .equal,
                toItem: self.facebookBtn,
                attribute:  NSLayoutAttribute.top,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.twitterBtn,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .width,
                multiplier: 1.0 / 3.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.twitterBtn,
                attribute: .height,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .height,
                multiplier: 1.0 / 4.0,
                constant: 0
            )]
        )
        
        // lineボタンの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.lineBtn,
                attribute:  NSLayoutAttribute.left,
                relatedBy: .equal,
                toItem: self.facebookBtn,
                attribute:  NSLayoutAttribute.left,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.lineBtn,
                attribute: NSLayoutAttribute.top,
                relatedBy: .equal,
                toItem: self.facebookBtn,
                attribute:  NSLayoutAttribute.bottom,
                multiplier: 1.2 / 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.lineBtn,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .width,
                multiplier: 1.0 / 3.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.lineBtn,
                attribute: .height,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .height,
                multiplier: 1.0 / 4.0,
                constant: 0
            )]
        )
        
        // ？ボタンの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.questionBtn,
                attribute:  NSLayoutAttribute.left,
                relatedBy: .equal,
                toItem: self.twitterBtn,
                attribute:  NSLayoutAttribute.left,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.questionBtn,
                attribute: NSLayoutAttribute.top,
                relatedBy: .equal,
                toItem: self.lineBtn,
                attribute:  NSLayoutAttribute.top,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.questionBtn,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .width,
                multiplier: 1.0 / 3.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.questionBtn,
                attribute: .height,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .height,
                multiplier: 1.0 / 4.0,
                constant: 0
            )]
        )
        
    }
}
