//
//  ViewController.swift
//  NeeNeeApp
//
//  Created by 石川晃次 on 2015/12/27.
//  Copyright © 2015年 KojiIshikawa. All rights reserved.
//

import UIKit
import iAd
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    private var myImageView: UIImageView!
    private var myCharImageView: UIImageView!
    private var myAudioPlayer: AVAudioPlayer!
    private var mySePlayer: AVAudioPlayer!
    
    private var manuBtn: UIButton!
    private var mainBtn: UIButton!
    private var detailBtn: UIButton!
    private var shareBtn: UIButton!
    private var configBtn: UIButton!
    
    private var bgmMuteBtn: UIButton!
    private var bgmVolumeSBar: UISlider!
    private var bgmLabel: UILabel!

    private var seMuteBtn: UIButton!
    private var seVolumeSBar: UISlider!
    private var seLabel: UILabel!
    
    private var mainConView: UIView!
    private var detailConView: UIView!
    private var shareConView: UIView!
    private var configConView: UIView!

    private var footerBaner: ADBannerView!
    
    private let mySongPath = NSBundle.mainBundle().pathForResource("落ち着くところ", ofType:"mp3")
    private let mySeYesPath = NSBundle.mainBundle().pathForResource("se4", ofType:"mp3")
    private let mySeNoPath = NSBundle.mainBundle().pathForResource("se6", ofType:"mp3")
    private let myImage = UIImage(named: "screen_01.jpg")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /* 以下の行を追加する */
        
        // UIImageViewを作成する.
        myImageView = UIImageView(frame: CGRectMake(0,0,self.view.bounds.width,self.view.bounds.height))
        
        // 画像をUIImageViewに設定する.
        myImageView.image = myImage
        
        // UIImageViewをViewに追加する.
        self.view.addSubview(myImageView)
        
        // キャラクターアニメーションを設定する.
        let charaImages = [
            UIImage( named: "character_1.jpg")!
/**
            UIImage( named: "character_1.jpg")!,
            UIImage( named: "character_2.jpg")!,
            UIImage( named: "character_3.jpg")!,
            UIImage( named: "character_4.jpg")!
**/
]
        myCharImageView = UIImageView(frame: CGRectMake(5,400,100,120))
        myCharImageView.animationImages = charaImages
        myCharImageView.tag = 1

        // キャラクターをタップ可能にする.
        myCharImageView.userInteractionEnabled = true
        let charaTap:UITapGestureRecognizer
             = UITapGestureRecognizer(target: self, action: "tapCharaImage:")
        myCharImageView.addGestureRecognizer(charaTap)
        
        // キャラクターを移動させる（無限ループ）
        callbackCharaMove()
        
        // アニメーションの設定をする.
        myCharImageView.startAnimating()
        
        // UIImageViewをViewに追加する.
        self.view.addSubview(myCharImageView)
        
        // フッタのバナーを生成する.
        footerBaner = ADBannerView(frame: CGRectMake(0,self.view.bounds.height-40,self.view.bounds.width,40))
        self.view.addSubview(footerBaner)
        
        // メニューボタン及びサブメニューボタンの設定.
        manuBtn = UIButton(frame: CGRectMake(self.view.bounds.width - 80,self.view.bounds.height - 100,60,100))
        manuBtn.setTitle("MENU",  forState: .Normal)
        manuBtn.addTarget(self, action: "tapManuBtn:", forControlEvents: .TouchUpInside)
        self.view.addSubview(manuBtn)
        
        mainBtn = UIButton(frame: CGRectMake(180,self.view.bounds.height - 100,100,100))
        mainBtn.setTitle("ひまつぶし",  forState: .Normal)
        mainBtn.addTarget(self, action: "tapMainBtn:", forControlEvents: .TouchUpInside)
        self.view.addSubview(mainBtn)
        
        detailBtn = UIButton(frame: CGRectMake(120,self.view.bounds.height - 100,60,100))
        detailBtn.setTitle("履歴書",  forState: .Normal)
        detailBtn.addTarget(self, action: "tapDetailBtn:", forControlEvents: .TouchUpInside)
        self.view.addSubview(detailBtn)
        
        shareBtn = UIButton(frame: CGRectMake(60,self.view.bounds.height - 100,60,100))
        shareBtn.setTitle("シェア",  forState: .Normal)
        shareBtn.addTarget(self, action: "tapShareBtn:", forControlEvents: .TouchUpInside)
        self.view.addSubview(shareBtn)
        
        configBtn = UIButton(frame: CGRectMake(0,self.view.bounds.height - 100,60,100))
        configBtn.setTitle("設定",  forState: .Normal)
        configBtn.addTarget(self, action: "tapConfigBtn:", forControlEvents: .TouchUpInside)
        self.view.addSubview(configBtn)
        
        // メニューボタン以外のボタンを非表示にする
        mainBtn.hidden = true
        detailBtn.hidden = true
        shareBtn.hidden = true
        configBtn.hidden = true
        
        //ポップ生成
        mainConView = UIView(frame: CGRectMake(18,100,340,400))
        
        if mainConView != nil {
            
            // ポップの背景色を設定する.
            mainConView.backgroundColor = UIColor(red: 20, green: 20, blue: 20, alpha: 0.9)
            
            // 初期表示は非表示
            mainConView.hidden = true
            
            // ViewをViewに追加する.
            self.view.addSubview(mainConView)
            
        }
        
        //ポップ生成
        detailConView = UIView(frame: CGRectMake(18,100,340,400))
        if detailConView != nil {
            
            // ポップの背景色を設定する.
            detailConView.backgroundColor = UIColor(red: 20, green: 20, blue: 20, alpha: 0.9)
            
            // 初期表示は非表示
            detailConView.hidden = true
            
            // ViewをViewに追加する.
            self.view.addSubview(detailConView)
            
        }
        
        //ポップ生成
        shareConView = UIView(frame: CGRectMake(18,100,340,400))
        if shareConView != nil {
            
            // ポップの背景色を設定する.
            shareConView.backgroundColor = UIColor(red: 20, green: 20, blue: 20, alpha: 0.9)
            
            // 初期表示は非表示
            shareConView.hidden = true
            
            // ViewをViewに追加する.
            self.view.addSubview(shareConView)
            
        }
        
        //ポップ生成
        configConView = UIView(frame: CGRectMake(18,100,340,400))
        if configConView != nil {
            
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
    
            // 非表示にしておく.
            bgmLabel.hidden = true
            bgmVolumeSBar.hidden = true
            bgmMuteBtn.hidden = true
            seLabel.hidden = true
            seVolumeSBar.hidden = true
            seMuteBtn.hidden = true
        }
        
        // テーマソングを再生する.
        do {
            myAudioPlayer = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath:mySongPath!))
            myAudioPlayer.numberOfLoops = -1
            myAudioPlayer.play()
            
        }catch{
            // 例外発生
        }
    }
    
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
            do {
                mySePlayer = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath:mySeYesPath!))
                mySePlayer.volume = seVolumeSBar.value * 2
                mySePlayer.play()
                
            }catch{
                // 例外発生
            }
            
        } else {
            
            // ボタンの文言を変える
            manuBtn.setTitle("MENU",  forState: .Normal)
            
            // メニュー内ボタンの制御を切り替える.
            mainBtn.hidden = true
            detailBtn.hidden = true
            shareBtn.hidden = true
            configBtn.hidden = true
            
            // SEを再生する.
            do {
                mySePlayer = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath:mySeNoPath!))
                mySePlayer.volume = seVolumeSBar.value * 2
                mySePlayer.play()
                
            }catch{
                // 例外発生
            }
        
        }
        


    }
    
    func tapMainBtn(sender: AnyObject) {
        
        // SEを再生する.
        do {
            mySePlayer = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath:mySeYesPath!))
            mySePlayer.volume = seVolumeSBar.value * 2
            mySePlayer.play()
            
        }catch{
            // 例外発生
        }

        if mainConView != nil {
            
            // ポップの表示・非表示を切り替える.
            mainConView.hidden = mainConView.hidden ? false:true
            
            // その他メニューボタンの制御を切り替える.
            manuBtn.userInteractionEnabled = mainConView.hidden ? true:false
            detailBtn.userInteractionEnabled = mainConView.hidden ? true:false
            shareBtn.userInteractionEnabled = mainConView.hidden ? true:false
            configBtn.userInteractionEnabled = mainConView.hidden ? true:false
        }
    }
    
    
    func tapDetailBtn(sender: AnyObject) {
        
        // SEを再生する.
        do {
            mySePlayer = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath:mySeYesPath!))
            mySePlayer.volume = seVolumeSBar.value * 2
            mySePlayer.play()
            
        }catch{
            // 例外発生
        }
        
        if detailConView != nil {
            
            // ポップの表示・非表示を切り替える.
            detailConView.hidden = detailConView.hidden ? false:true
            
            // その他メニューボタンの制御を切り替える.
            manuBtn.userInteractionEnabled = detailConView.hidden ? true:false
            mainBtn.userInteractionEnabled = detailConView.hidden ? true:false
            shareBtn.userInteractionEnabled = detailConView.hidden ? true:false
            configBtn.userInteractionEnabled = detailConView.hidden ? true:false
        }
    }
    
    func tapShareBtn(sender: AnyObject) {
        
        // SEを再生する.
        do {
            mySePlayer = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath:mySeYesPath!))
            mySePlayer.volume = seVolumeSBar.value * 2
            mySePlayer.play()
            
        }catch{
            // 例外発生
        }
        
        if shareConView != nil {
            
            // ポップの表示・非表示を切り替える.
            shareConView.hidden = shareConView.hidden ? false:true
            
            // その他メニューボタンの制御を切り替える.
            manuBtn.userInteractionEnabled = shareConView.hidden ? true:false
            mainBtn.userInteractionEnabled = shareConView.hidden ? true:false
            detailBtn.userInteractionEnabled = shareConView.hidden ? true:false
            configBtn.userInteractionEnabled = shareConView.hidden ? true:false
        }
        
    }
    
    func tapConfigBtn(sender: AnyObject) {
        
        // SEを再生する.
        do {
            mySePlayer = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath:mySeYesPath!))
            mySePlayer.volume = seVolumeSBar.value * 2
            mySePlayer.play()
            
        }catch{
            // 例外発生
        }
        
            if configConView != nil {
                
                // オブジェクトの表示・非表示を切り替える.
                configConView.hidden = configConView.hidden ? false:true
                bgmLabel.hidden = bgmLabel.hidden ? false:true
                bgmVolumeSBar.hidden = bgmVolumeSBar.hidden ? false:true
                bgmMuteBtn.hidden = bgmMuteBtn.hidden ? false:true
                seLabel.hidden = seLabel.hidden ? false:true
                seVolumeSBar.hidden = seVolumeSBar.hidden ? false:true
                seMuteBtn.hidden = seMuteBtn.hidden ? false:true
                
                // その他メニューボタンの制御を切り替える.
                manuBtn.userInteractionEnabled = configConView.hidden ? true:false
                mainBtn.userInteractionEnabled = configConView.hidden ? true:false
                detailBtn.userInteractionEnabled = configConView.hidden ? true:false
                shareBtn.userInteractionEnabled = configConView.hidden ? true:false
            }
    }
    
    func tapBgmMuteBtn(sender: AnyObject) {
        
        // SEを再生する.
        do {
            mySePlayer = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath:mySeYesPath!))
            mySePlayer.volume = seVolumeSBar.value * 2
            mySePlayer.play()
            
        }catch{
            // 例外発生
        }
        
        // ミュート切り替え
        if myAudioPlayer.volume == 0.0 {
            
            myAudioPlayer.volume = 0.5
            bgmVolumeSBar.value = 0.5
            
        } else {
            
            myAudioPlayer.volume = 0.0
            bgmVolumeSBar.value = 0.0
        }
    }

    func slideBgmVolume(sender: AnyObject) {
        
        // スライド値をBGM音量にセットする
        myAudioPlayer.volume = bgmVolumeSBar.value
        
    }

    func tapSeMuteBtn(sender: AnyObject) {
        
        // SEを再生する.
        do {
            mySePlayer = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath:mySeYesPath!))
            mySePlayer.volume = seVolumeSBar.value * 2
            mySePlayer.play()
            
        }catch{
            // 例外発生
        }
        
        // ミュート切り替え
        if mySePlayer.volume == 0.0 {
            
            mySePlayer.volume = 1.0
            seVolumeSBar.value = 0.5
            
        } else {
            
            mySePlayer.volume = 0.0
            seVolumeSBar.value = 0.0
        }
    }
    
    func slideSeVolume(sender: AnyObject) {
        
        // スライド値をBGM音量にセットする
        mySePlayer.volume = seVolumeSBar.value * 2
        
    }

    func tapCharaImage(sender: UITapGestureRecognizer) {
        
        /**
        // ダイアログを表示
        let alertController = UIAlertController(title: "ニートのつぶやき", message: "チラシを表示して、今日のニートの一言を取得しますか？", preferredStyle: .Alert)
        
        let defaultActionYes = UIAlertAction(title: "表示する", style: .Default, handler: nil)
        let defaultActionNo = UIAlertAction(title: "表示しない", style: .Default, handler: nil)
        alertController.addAction(defaultActionYes)
        alertController.addAction(defaultActionNo)
        
        presentViewController(alertController, animated: true, completion: nil)
**/

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 画面にタッチで呼ばれる
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touchesBegan")
        
        // タッチイベントを取得
        let touchEvent = touches.first!

        //キャラクターの座標を取得
        print(touchEvent.previousLocationInView(myCharImageView).x)
        print(touchEvent.previousLocationInView(myCharImageView).y)
        print(touchEvent.view?.tag.description)
        
        // 画像がタップされた場合
        if touchEvent.view?.tag == 1
        {
            // ダイアログを表示
            let alertController = UIAlertController(title: "ニートのつぶやき", message: "チラシを表示して、今日のニートの一言を取得しますか？", preferredStyle: .Alert)
            
            let defaultActionYes = UIAlertAction(title: "表示する", style: .Default, handler: nil)
            let defaultActionNo = UIAlertAction(title: "表示しない", style: .Default, handler: nil)
            alertController.addAction(defaultActionYes)
            alertController.addAction(defaultActionNo)
            
            presentViewController(alertController, animated: true, completion: nil)
        }
        
        
    }
    
    func callbackCharaMove() {
        
        // 横移動させる.
        UIView.animateWithDuration(
            10, // アニメーションの時間
            delay:2.0,
            options:[UIViewAnimationOptions.TransitionCrossDissolve,UIViewAnimationOptions.AllowUserInteraction],
            animations: {() -> Void  in
                
                // 左端から右端へ移動
                self.myCharImageView.frame.origin.x = UIScreen.mainScreen().bounds.width - 100
            },
            completion: {(finished: Bool) -> Void in
                
                // アニメーション終了後の処理
                UIView.animateWithDuration(
                    10, // アニメーションの時間
                    delay:2.0,
                    options:[UIViewAnimationOptions.TransitionCrossDissolve,UIViewAnimationOptions.AllowUserInteraction],
                    animations: {() -> Void  in
                        
                        // 左端から右端へ移動
                        self.myCharImageView.frame.origin.x = 5
                    },
                    completion: {(finished: Bool) -> Void in
                        // アニメーション終了後の処理
                        self.callbackCharaMove()
                })
                
        })
        
    }
    
    
}

