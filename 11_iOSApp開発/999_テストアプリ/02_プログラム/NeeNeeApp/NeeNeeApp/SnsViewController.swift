//
//  SNSViewController.swift
//  NeeNeeApp
//
//  Created by v2_system on 2016/02/11.
//  Copyright © 2016年 KojiIshikawa. All rights reserved.
//

import Foundation
import Social





//SNS画面です。
class SnsViewController: UIViewController,UIGestureRecognizerDelegate {

    private let shareViewImage = UIImage(named: "02_03_01.png")
    private let configViewImage = UIImage(named: "02_04_01.png")
    
    // シェアメニューのオブジェクト
    private var shareImgView: UIImageView!
    
    private var facebookBtn: UIButton!
    private var lineBtn: UIButton!
    private var twitterBtn: UIButton!
    

    
    
    // view ロード完了時
    override func viewDidLoad() {
        print(NSDate().description, __FUNCTION__, __LINE__)
        super.viewDidLoad()

        //ポップ生成
        shareImgView = UIImageView(frame: self.view.frame)
        shareImgView.image = shareViewImage
        shareImgView.alpha = 0.9
        self.view.addSubview(shareImgView)
        
        // FaceBookボタンを生成
        facebookBtn = UIButton(frame: CGRectMake(20,120,50,50))
        let facebookImage = Utility.getUncachedImage( named: "01_07_01.png")! as UIImage
        facebookBtn.setImage(facebookImage, forState: .Normal)
        facebookBtn.addTarget(self, action: "tapFacebookBtn:", forControlEvents: .TouchUpInside)
        self.view.addSubview(facebookBtn)
        
//        let singleTap = UITapGestureRecognizer(target: self, action:"tapFacebookBtn:")
//        singleTap.numberOfTapsRequired = 1
//        singleTap.delegate = self
//        self.facebookBtn.addGestureRecognizer(singleTap)
        
        // Twitterボタンを生成
        twitterBtn = UIButton(frame: CGRectMake(100,120,50,50))
        let twitterImage = Utility.getUncachedImage( named: "01_08_01.png")! as UIImage
        twitterBtn.setImage(twitterImage, forState: .Normal)
        twitterBtn.addTarget(self, action: "tapTwitterBtn:", forControlEvents: .TouchUpInside)
        self.view.addSubview(twitterBtn)
        
        // LINEボタンを生成
        lineBtn = UIButton(frame: CGRectMake(180,120,50,50))
        let lineImage = Utility.getUncachedImage( named: "01_09_01.png")! as UIImage
        lineBtn.setImage(lineImage, forState: .Normal)
        lineBtn.addTarget(self, action: "tapLineBtn:", forControlEvents: .TouchUpInside)
        self.view.addSubview(lineBtn)
    }
    
    //メモリ消費が多くなった時に動くイベント
    override func didReceiveMemoryWarning() {
        print(NSDate().description, __FUNCTION__, __LINE__)
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    
//    func tapFacebookBtn(recognizer: UITapGestureRecognizer) {
//        print("test")
//    }

    
    
    //facebookボタン押下時の処理
    func tapFacebookBtn(sender: AnyObject) {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        // Facebookの投稿ダイアログを作って
        let cv = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        // 画像を追加
        cv.addImage(UIImage(named: "01_07_01.png"))
        // 投稿ダイアログを表示する
        self.presentViewController(cv, animated: true, completion: nil)
    }
    
    //ラインボタン押下時の処理
    func tapLineBtn(sender: AnyObject) {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        //　共有する項目
        let shareImage = UIImage(named: "01_09_01.png")!
        let shareItems = [shareImage]
        
        // LINEで送るボタンを追加
        let line = LINEActivity()
        let avc = UIActivityViewController(activityItems: shareItems, applicationActivities: [line])
        
        presentViewController(avc, animated: true, completion: nil)
    }
    
    //Twitterボタン押下時の処理
    func tapTwitterBtn(sender: AnyObject) {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        // 共有する項目
        // Twitterの投稿ダイアログを作って
        let cv = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        // 文字を追加
        cv.setInitialText("メッセージを入力してください。")
        // 投稿ダイアログを表示する
        self.presentViewController(cv, animated: true, completion:nil )
    }

    
}
