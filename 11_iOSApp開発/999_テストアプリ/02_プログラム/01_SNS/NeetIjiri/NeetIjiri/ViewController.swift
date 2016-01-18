//
//  ViewController.swift
//  NeetIjiri
//
//  Created by v2_system on 2016/01/04.
//  Copyright © 2016年 v2_system. All rights reserved.
//

import UIKit
import Social
import CoreData


class ViewController: UIViewController,UIPopoverPresentationControllerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //ポップオーバボタン押下
    @IBAction func popOver(sender: UIButton) {
        
        self.performSegueWithIdentifier("showView", sender: self)
        
        
    }
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return .None
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "showView"
        {
            let vc = segue.destinationViewController
            
            let controller = vc.popoverPresentationController
            
            if controller != nil
            {
                controller?.delegate = self
            }
        }
        
    }

    
    //facebookボタン押下
    @IBAction func tapFacebookBtn(sender: AnyObject) {
        
        // Facebookの投稿ダイアログを作って
        let cv = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        // 画像を追加
        cv.addImage(UIImage(named: "facebook.png"))
        // 投稿ダイアログを表示する
        self.presentViewController(cv, animated: true, completion: nil)
    }

    
    
    
    //ラインボタン押下
    @IBAction func tapLine(sender: AnyObject) {
        //　共有する項目
        let shareImage = UIImage(named: "LINEActivityIcon.png")!
        let shareItems = [shareImage]
        
        // LINEで送るボタンを追加
        let line = LINEActivity()
        let avc = UIActivityViewController(activityItems: shareItems, applicationActivities: [line])
    
        
        presentViewController(avc, animated: true, completion: nil)
        
        
    }
    
    
    //Twitterボタン
    @IBAction func tapTwitter(sender: AnyObject) {
        
        // 共有する項目
        // Twitterの投稿ダイアログを作って
        let cv = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        // 文字を追加
        cv.setInitialText("メッセージを入力してください。")
        // 投稿ダイアログを表示する
        self.presentViewController(cv, animated: true, completion:nil )
    }
    
    
    
    
}

