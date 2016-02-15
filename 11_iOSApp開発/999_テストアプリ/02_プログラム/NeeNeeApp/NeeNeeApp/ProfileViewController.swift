//
//  ProfileViewController.swift
//  NeeNeeApp
//
//  Created by v2_system on 2016/02/11.
//  Copyright © 2016年 KojiIshikawa. All rights reserved.
//

import Foundation



// 履歴書画面です。
class ProfileViewController: UIViewController {

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

        // キャラクター基本情報を取得する.
        let charaData = getCharaBase()
        
        // プロフィール設定
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
        self.positionDataLabel = UILabel(frame: CGRectMake(100,100,100,100))
        self.positionDataLabel.textAlignment = .Left
        self.positionDataLabel.text = getJobName()

        // 格言履歴（scrollview）
        self.kakugenHistoryScrollView = UIScrollView()
        //self.kakugenHistoryScrollView

        // 行動履歴（scrollview）
        self.actionHistoryScrollView = UIScrollView()
        //self.actionHistoryScrollView.
        
        // 行った場所の履歴（scrollview）
        self.compHistoryScrollView = UIScrollView()
        //self.compHistoryScrollView

        // ポップ上に表示するオブジェクトをViewに追加する.
        self.view.addSubview(detailImgView)
        self.view.addSubview(nameDataLabel)
        self.view.addSubview(birthDataLabel)
        self.view.addSubview(positionDataLabel)
        self.view.addSubview(kakugenHistoryScrollView)
        self.view.addSubview(actionHistoryScrollView)
        self.view.addSubview(compHistoryScrollView)
        self.view.addSubview(nameDataLabel)
        self.view.addSubview(birthDataLabel)
        self.view.addSubview(positionDataLabel)

    }
    
    //メモリ消費が多くなった時に動くイベント
    override func didReceiveMemoryWarning() {
        print(NSDate().description, __FUNCTION__, __LINE__)
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //基本情報の取得
    func getCharaBase() -> [T_CharaBase]  {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        return T_CharaBase.MR_findAll() as! [T_CharaBase];
    }
    
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
                    kakugenList.append(mKakugenItem.kakugenText)
                    
                } else {
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
                    stageList.append(mStageItem.stageName)
                    
                } else {
                    stageList.append(Const.QUESTION_TEXT)
                }
                
            }
        }
        
        // ステージリストを返却する.
        return stageList
    }

    
}
