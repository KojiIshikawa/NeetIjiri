//
//  SettingViewController.swift
//  NeeNeeApp
//
//  Created by v2_system on 2016/02/11.
//  Copyright © 2016年 KojiIshikawa. All rights reserved.
//

import Foundation
import AVFoundation
//設定画面です。
class SettingViewController: UIViewController ,AVAudioPlayerDelegate{
    // 設定メニューのオブジェクト
    private var bgmMuteBtn: UIButton!
    private var bgmVolumeSBar: UISlider!
    private var bgmLabel: UILabel!
    private var seMuteBtn: UIButton!
    private var seVolumeSBar: UISlider!
    private var seLabel: UILabel!

    // BGM・SEの再生用オブジェクト
    private var myAudioPlayer: AVAudioPlayer!
    private var mySePlayer: AVAudioPlayer!

    
    internal let mySeYesPath = NSBundle.mainBundle().pathForResource("se4", ofType:"mp3")
    private let mySeNoPath = NSBundle.mainBundle().pathForResource("se6", ofType:"mp3")
   
    
    private var settingImgView: UIImageView!
    private let settingViewImage = UIImage(named: "02_04_01.png")

    // view ロード完了時
    override func viewDidLoad() {
        print(NSDate().description, __FUNCTION__, __LINE__)
        super.viewDidLoad()
        
        
        //ポップ生成
//        settingConView = UIView(frame: CGRectMake(18,100,340,400))
        settingImgView = UIImageView(frame: self.view.frame)
//        settingImgView.frame.size = settingConView.frame.size

        settingImgView.image = settingViewImage
        settingImgView.alpha = 0.9
        
//        // 初期表示は非表示
//        settingConView.hidden = true
        
        // ポップアップViewをViewに追加する.
        self.view.addSubview(settingImgView)
        
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
//        settingImgView.addSubview(settingImgView)
        settingImgView.addSubview(bgmLabel)
        settingImgView.addSubview(bgmVolumeSBar)
        settingImgView.addSubview(bgmMuteBtn)
        settingImgView.addSubview(seLabel)
        settingImgView.addSubview(seVolumeSBar)
        settingImgView.addSubview(seMuteBtn)

        
    }
    
    //メモリ消費が多くなった時に動くイベント
    override func didReceiveMemoryWarning() {
        print(NSDate().description, __FUNCTION__, __LINE__)
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    
    
    
    
    /** BGMボリューム変更時の処理 **/
    func slideBgmVolume(sender: AnyObject) {
        
        // スライド値をBGM音量にセットする
        myAudioPlayer.volume = bgmVolumeSBar.value
        
    }

    /** BGMミュートボタン押下時の処理 **/
    func tapBgmMuteBtn(sender: AnyObject) {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        // SEを再生する.
        Utility.seSoundPlay(mySeYesPath!)
        
        // ミュート切り替え
        if myAudioPlayer.volume == 0.0 {
            
            myAudioPlayer.volume = 0.5
            bgmVolumeSBar.value = 0.5
            
        } else {
            
            myAudioPlayer.volume = 0.0
            bgmVolumeSBar.value = 0.0
        }
    }
    
    
    /** SEボリューム変更時の処理 **/
    func slideSeVolume(sender: AnyObject) {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        // スライド値をBGM音量にセットする
        //        mySePlayer.volume = seVolumeSBar.value * 2
        
    }

    
    /** SEミュートボタン押下時の処理 **/
    func tapSeMuteBtn(sender: AnyObject) {
        
        // SEを再生する.
        Utility.seSoundPlay(mySeYesPath!)
        
        // ミュート切り替え
        if mySePlayer.volume == 0.0 {
            
            mySePlayer.volume = 1.0
            seVolumeSBar.value = 0.5
            
        } else {
            
            mySePlayer.volume = 0.0
            seVolumeSBar.value = 0.0
        }
    }
    
}
