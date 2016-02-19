//
//  ProfileViewController.swift
//  NeeNeeApp
//
//  Created by v2_system on 2016/02/11.
//  Copyright © 2016年 KojiIshikawa. All rights reserved.
//

import Foundation

// 履歴書画面です。
class ProfileViewController: UIViewController,UIScrollViewDelegate {

    // 履歴書メニューのオブジェクト
    private var detailImgView: UIImageView!
    private let detailViewImage = UIImage(named: "02_02_01.png")

    // 履歴書に表示する項目のオブジェクト
    private var nameDataLabel: UILabel!
    private var birthDataLabel: UILabel!
    private var positionDataLabel: UILabel!
    private var kakugenHistoryScrollView: UIScrollView!
    private var actionHistoryScrollView: UIScrollView!
    private var compHistoryScrollView: UIScrollView!

    // view ロード完了時
    override func viewDidLoad() {
        print(NSDate().description, __FUNCTION__, __LINE__)
        super.viewDidLoad()

        //背景設定
        detailImgView = UIImageView(frame: self.view.frame)
        detailImgView.image = detailViewImage
        
        // プロフィール設定
        // キャラクター基本情報を取得する.
        let charaData : [T_CharaBase] = Utility.getCharaBase(Const.CHARACTER1_ID)

        // 名前
        self.nameDataLabel = UILabel()
        self.nameDataLabel.textAlignment = .Left
        self.nameDataLabel.text = charaData[0].charaName

        // 生年月日
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        self.birthDataLabel = UILabel()
        self.birthDataLabel.textAlignment = .Left
        self.birthDataLabel.text = dateFormatter.stringFromDate(charaData[0].charaBirth)

        // 役職
        self.positionDataLabel = UILabel()
        self.positionDataLabel.textAlignment = .Left
        self.positionDataLabel.text = getJobName()

        // 格言履歴（scrollview）
        self.kakugenHistoryScrollView = UIScrollView()
        self.kakugenHistoryScrollView.delegate = self
        self.kakugenHistoryScrollView.contentSize = CGSizeMake(100,100)

        // 行動履歴（scrollview）
        self.actionHistoryScrollView = UIScrollView()
        self.actionHistoryScrollView.delegate = self
        self.actionHistoryScrollView.contentSize = CGSizeMake(100,100)
        
        // 行った場所の履歴（scrollview）
        self.compHistoryScrollView = UIScrollView()
        self.compHistoryScrollView.delegate = self
        self.compHistoryScrollView.contentSize = CGSizeMake(100,100)

        // ポップ上に表示するオブジェクトをViewに追加する.
        self.view.addSubview(detailImgView)
        self.view.addSubview(nameDataLabel)
        self.view.addSubview(birthDataLabel)
        self.view.addSubview(positionDataLabel)
        self.view.addSubview(kakugenHistoryScrollView)
        self.view.addSubview(actionHistoryScrollView)
        self.view.addSubview(compHistoryScrollView)
        
        // 全オブジェクトの制約設定.
        objConstraints()

    }
    
    //メモリ消費が多くなった時に動くイベント
    override func didReceiveMemoryWarning() {
        print(NSDate().description, __FUNCTION__, __LINE__)
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /** 全オブジェクトの制約設定 **/
    func objConstraints() {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        nameDataLabel.translatesAutoresizingMaskIntoConstraints = false
        birthDataLabel.translatesAutoresizingMaskIntoConstraints = false
        positionDataLabel.translatesAutoresizingMaskIntoConstraints = false
        kakugenHistoryScrollView.translatesAutoresizingMaskIntoConstraints = false
        actionHistoryScrollView.translatesAutoresizingMaskIntoConstraints = false
        compHistoryScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        // 名前の制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.nameDataLabel,
                attribute:  NSLayoutAttribute.CenterX,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.CenterX,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.nameDataLabel,
                attribute: NSLayoutAttribute.Top,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 20
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.nameDataLabel,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0 / 2.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.nameDataLabel,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0,
                constant: 20
            )]
        )

        // 生年月日の制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.birthDataLabel,
                attribute:  NSLayoutAttribute.CenterX,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.CenterX,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.birthDataLabel,
                attribute: NSLayoutAttribute.Top,
                relatedBy: .Equal,
                toItem: self.nameDataLabel,
                attribute:  NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 20
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.birthDataLabel,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0 / 2.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.birthDataLabel,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0,
                constant: 20
            )]
        )
        
        // 役職の制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.positionDataLabel,
                attribute:  NSLayoutAttribute.CenterX,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.CenterX,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.positionDataLabel,
                attribute: NSLayoutAttribute.Top,
                relatedBy: .Equal,
                toItem: self.birthDataLabel,
                attribute:  NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 20
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.positionDataLabel,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0 / 2.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.positionDataLabel,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0,
                constant: 20
            )]
        )
        
        // 格言履歴の制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.kakugenHistoryScrollView,
                attribute:  NSLayoutAttribute.CenterX,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.CenterX,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.kakugenHistoryScrollView,
                attribute: NSLayoutAttribute.Top,
                relatedBy: .Equal,
                toItem: self.positionDataLabel,
                attribute:  NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 20
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.kakugenHistoryScrollView,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0 / 2.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.kakugenHistoryScrollView,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0,
                constant: 60
            )]
        )
        
        // 行動履歴の制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.actionHistoryScrollView,
                attribute:  NSLayoutAttribute.CenterX,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.CenterX,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.actionHistoryScrollView,
                attribute: NSLayoutAttribute.Top,
                relatedBy: .Equal,
                toItem: self.kakugenHistoryScrollView,
                attribute:  NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 20
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.actionHistoryScrollView,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0 / 2.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.actionHistoryScrollView,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0,
                constant: 60
            )]
        )
        
        // 行った場所の制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.compHistoryScrollView,
                attribute:  NSLayoutAttribute.CenterX,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.CenterX,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.compHistoryScrollView,
                attribute: NSLayoutAttribute.Top,
                relatedBy: .Equal,
                toItem: self.actionHistoryScrollView,
                attribute:  NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 20
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.compHistoryScrollView,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0 / 2.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.compHistoryScrollView,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0,
                constant: 60
            )]
        )
    }
    
    //****************************************
    // MARK: - Scroll View Delegate
    //****************************************

    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        print(NSDate().description, __FUNCTION__, __LINE__)
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        print(NSDate().description, __FUNCTION__, __LINE__)

    }
    
    //****************************************
    // MARK: - DB Access
    //****************************************
    
    //役職名の取得
    func getJobName() -> String  {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        // キャラクターIDが一致する最大のジョブIDを取得する.
        let tRefJob:[T_RefJob] = T_RefJob.MR_findByAttribute("charaID", withValue: Const.CHARACTER1_ID, andOrderBy: "jobID", ascending: false) as! [T_RefJob];
        
        // 役職マスタを全件取得する.
        let mJob:[M_Job] = M_Job.MR_findAll() as! [M_Job];

        print(tRefJob.count)
        print(mJob.count)
        
        // 役職マスタとキーが一致する場合、名称を返却して終了
        for jobItem in mJob {
            
            if jobItem.jobID == tRefJob[0].jobID {
             
                return jobItem.jobName
            }
            
        }
        
        // 取得できない場合、StringEmptyを返却する.
        return ""
    }

    //格言履歴の取得
    func getKakugenHistory() -> [String]  {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        // キャラクターが保有する格言IDを取得する.（格言IDの昇順）
        let tRefKakugen:[T_RefKakugen] = T_RefKakugen.MR_findByAttribute("charaID", withValue: Const.CHARACTER1_ID, andOrderBy: "kakugenID", ascending: true) as! [T_RefKakugen];
        
        // 格言マスタを全件取得する.（格言IDの昇順）
        let mKakugen:[M_Kakugen] = M_Kakugen.MR_findAllSortedBy("kakugenID", ascending: true) as! [M_Kakugen];
        
        // 返却するリスト
        var kakugenList : [String] = []
        
        print(tRefKakugen.count)
        print(mKakugen.count)
        
        // 格言マスタとキーが一致する場合、名称を返却して終了
        for mKakugenItem in mKakugen {
            
            for tKakugenItem in tRefKakugen {
            
                if mKakugenItem.kakugenID == tKakugenItem.kakugenID {

                    //取得済みデータはそのままセットする.
                    kakugenList.append(mKakugenItem.kakugenText)
                    
                } else {
                    
                    //未取得データはマスキングしてセットする.
                    kakugenList.append(Const.QUESTION_TEXT)
                }
            
            }
        }
        
        // 格言リストを返却する.
        return kakugenList
    }
 
    //行った場所の履歴の取得
    func getStageHistory() -> [String]  {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        // キャラクターが保有するステージIDを取得する.（ステージIDの昇順）
        let tRefStage:[T_RefStage] = T_RefStage.MR_findByAttribute("charaID", withValue: Const.CHARACTER1_ID, andOrderBy: "stageID", ascending: true) as! [T_RefStage];
        
        // ステージマスタを全件取得する.（ステージIDの昇順）
        let mStage:[M_Stage] = M_Kakugen.MR_findAllSortedBy("stageID", ascending: true) as! [M_Stage];
        
        // 返却するリスト
        var stageList : [String] = []
        
        print(tRefStage.count)
        print(mStage.count)
        
        // ステージマスタとキーが一致する場合、名称を返却して終了
        for mStageItem in mStage {
            
            for tStageItem in tRefStage {
                
                if mStageItem.stageID == tStageItem.stageID {
                    
                    //取得済みデータはそのままセットする.
                    stageList.append(mStageItem.stageName)
                    
                } else {
                    
                    //未取得データはマスキングしてセットする.
                    stageList.append(Const.QUESTION_TEXT)
                }
                
            }
        }
        
        // ステージリストを返却する.
        return stageList
    }

    
}
