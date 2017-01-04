//
//  StoryViewController.swift
//  NeeNeeApp
//
//  Created by 石川晃次 on 2017/01/04.
//  Copyright © 2017年 KojiIshikawa. All rights reserved.
//

import Foundation

class StoryViewController: UIViewController,UIGestureRecognizerDelegate {
    
    // ラベルオブジェクト
    fileprivate var storyLabel: UILabel!
    private var cnt :Int8 = 0
    
    // view ロード完了時
    override func viewDidLoad() {
        print(Date().description, NSStringFromClass(self.classForCoder), #function,#line)
        super.viewDidLoad()

        // view設定
        self.view.backgroundColor = .black
        let singleTap = UITapGestureRecognizer(target: self, action:#selector(StoryViewController.tapStory(_:)))
        self.view.addGestureRecognizer(singleTap)

        // ラベル設定
        storyLabel = UILabel()
        storyLabel.numberOfLines = 0
        storyLabel.text  = "ん・・・、ここはどこだ・・・！\n\n"
        storyLabel.textColor = UIColor.white
        storyLabel.font = UIFont.systemFont(ofSize: Utility.getMojiSize(Const.SIZEKBN_MIDDLE))
        self.view.addSubview(storyLabel)
        
        // オブジェクトの制約の設定
        self.objConstraints()
        
        // BGMを再生する.
        Utility.bgmSoundPlay(Const.BGM_STORY_PATH)
    }
    
    /** 画面タッチ時の処理 **/
    // ジェスチャーイベント処理
    func tapStory(_ gestureRecognizer: UITapGestureRecognizer){
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        
        // SEを再生する.
        Utility.seSoundPlay(Const.SE_NO_PATH)
        
        switch cnt {

        case 0:
            storyLabel.text? += "妖精が目を開けると、歳のわりに幼い顔をし、\n"
            storyLabel.text? += "肌がみょうに青白いひとりの青年、いや、\n"
            storyLabel.text? += "中年がそこにいた。\n\n"
            
        case 1:
            storyLabel.text? += "「これはもしやニートか・・・？\n"
            storyLabel.text? += "　神さまからは、ゆうしゅうなエリートの\n"
            storyLabel.text? += "　青年の担当だときいていたのに・・・。\n"
            storyLabel.text? += "　まぁいいか、少しだけあそんでやろう」\n\n"
            
        case 2:
            storyLabel.text? += "・・・そう、あなたは人の行動を操ることが\nできる妖精です。\n\n"
            storyLabel.text? += "あなたは、ニートくんの行動（ひまつぶし）\n"
            storyLabel.text? += "をセットして行動をあやつることできます。\n"
            storyLabel.text? += "ニートくんがどのようなひまつぶしをするか、\n"
            storyLabel.text? += "それはあなたしだいです。\n\n"
            
        case 3 :
            storyLabel.text? += "さあ、ニートくんが起きてきましたよ・・・！"
            
        default:

            // BGMを止める
            Utility.bgmStop()
            
            // 画面遷移する.
            let NextViewController = self.storyboard!.instantiateViewController( withIdentifier: "NeetMain" )
            NextViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present( NextViewController, animated: true, completion: nil)

        }
        cnt += 1
    }
    
    /** 全オブジェクトの制約設定 **/
    func objConstraints() {
        print(Date().description, NSStringFromClass(self.classForCoder), #function,#line)
        
        storyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // ラベルの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.storyLabel,
                attribute:  NSLayoutAttribute.centerX,
                relatedBy: .equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.centerX,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.storyLabel,
                attribute: NSLayoutAttribute.top,
                relatedBy: .equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.top,
                multiplier: 1.2 / 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.storyLabel,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .width,
                multiplier: 0.8 / 1.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.storyLabel,
                attribute: .height,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .height,
                multiplier: 1.0,
                constant: 0
            )]
        )
    }
    
}
