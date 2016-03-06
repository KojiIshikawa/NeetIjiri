//
//  ProfileViewController.swift
//  NeeNeeApp
//
//  Created by v2_system on 2016/02/11.
//  Copyright © 2016年 KojiIshikawa. All rights reserved.
//

import Foundation

// 履歴書画面です。
class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    // 履歴書メニューのオブジェクト
    private var detailImgView: UIImageView!
    private let detailViewImage = UIImage(named: "02_02_01.png")

    // 履歴書に表示する項目のオブジェクト
    private var nameDataLabel: UILabel!
    private var birthDataLabel: UILabel!
    private var positionDataLabel: UILabel!
    private var tableViewKakugenHistory: UITableView!
    private var tableViewActionHistory: UITableView!
    private var tableViewCompHistory: UITableView!

    //コレクションビューにセットするアイテムリスト
    private var listStage: [String] = []
    private var listAction: [String] = []
    private var listKakugen: [String] = []

    
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

        // TableViewにセットするデータを取得する.
        listStage = getStageHistory()
        listAction = getActionHistory()
        listKakugen = getKakugenHistory()

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

        // 格言履歴（tableview）
        self.tableViewKakugenHistory = UITableView()
        self.tableViewKakugenHistory.delegate = self
        self.tableViewKakugenHistory.dataSource = self
        //self.tableViewKakugenHistory.contentSize = CGSizeMake(100,100)
        self.tableViewKakugenHistory.tag = 11

        // 行動履歴（tableview）
        self.tableViewActionHistory = UITableView()
        self.tableViewActionHistory.delegate = self
        self.tableViewActionHistory.dataSource = self
        //self.tableViewActionHistory.contentSize = CGSizeMake(100,100)
        self.tableViewActionHistory.tag = 12
        
        // 行った場所の履歴（tableview）
        self.tableViewCompHistory = UITableView()
        self.tableViewCompHistory.delegate = self
        self.tableViewCompHistory.dataSource = self
        //self.tableViewCompHistory.contentSize = CGSizeMake(100,100)
        self.tableViewCompHistory.tag = 13
        
        // ポップ上に表示するオブジェクトをViewに追加する.
        self.view.addSubview(detailImgView)
        self.view.addSubview(nameDataLabel)
        self.view.addSubview(birthDataLabel)
        self.view.addSubview(positionDataLabel)
        self.view.addSubview(tableViewKakugenHistory)
        self.view.addSubview(tableViewActionHistory)
        self.view.addSubview(tableViewCompHistory)
        
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
        tableViewKakugenHistory.translatesAutoresizingMaskIntoConstraints = false
        tableViewActionHistory.translatesAutoresizingMaskIntoConstraints = false
        tableViewCompHistory.translatesAutoresizingMaskIntoConstraints = false
        
        // 名前の制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.nameDataLabel,
                attribute:  .Left,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  .CenterX,
                multiplier: 1.0,
                constant: -80
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.nameDataLabel,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  .Top,
                multiplier: 1.0,
                constant: 100
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
                multiplier: 1.0 / 20.0,
                constant: 0
            )]
        )

        // 生年月日の制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.birthDataLabel,
                attribute:  .Left,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  .CenterX,
                multiplier: 1.0,
                constant: -80
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.birthDataLabel,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: self.nameDataLabel,
                attribute:  .Bottom,
                multiplier: 1.0,
                constant: 10
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
                multiplier: 1.0 / 20.0,
                constant: 0
            )]
        )
        
        // 役職の制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.positionDataLabel,
                attribute:  .Left,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  .CenterX,
                multiplier: 1.0,
                constant: -80
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.positionDataLabel,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: self.birthDataLabel,
                attribute:  .Bottom,
                multiplier: 1.0,
                constant: 10
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.positionDataLabel,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0 / 1.2,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.positionDataLabel,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0 / 20.0,
                constant: 0
            )]
        )
        
        // 格言履歴の制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.tableViewKakugenHistory,
                attribute:  .Left,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  .CenterX,
                multiplier: 1.0,
                constant: -80
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.tableViewKakugenHistory,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: self.positionDataLabel,
                attribute:  .Bottom,
                multiplier: 1.0,
                constant: 10
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.tableViewKakugenHistory,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0 / 1.4,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.tableViewKakugenHistory,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0 / 6.0,
                constant: 0
            )]
        )
        
        // 行動履歴の制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.tableViewActionHistory,
                attribute:  .Left,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  .CenterX,
                multiplier: 1.0,
                constant: -80
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.tableViewActionHistory,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: self.tableViewKakugenHistory,
                attribute:  .Bottom,
                multiplier: 1.0,
                constant: 10
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.tableViewActionHistory,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0 / 1.4,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.tableViewActionHistory,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0 / 6.0,
                constant: 0
            )]
        )
        
        // 行った場所の制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.tableViewCompHistory,
                attribute:  .Left,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  .CenterX,
                multiplier: 1.0,
                constant: -80
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.tableViewCompHistory,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: self.tableViewActionHistory,
                attribute:  .Bottom,
                multiplier: 1.0,
                constant: 10
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.tableViewCompHistory,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0 / 1.4,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.tableViewCompHistory,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0 / 6.0,
                constant: 0
            )]
        )
    }
    
    //****************************************
    // MARK: - Table View Delegate
    //****************************************    
    // セルの行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        switch tableView.tag {
            
        // 格言履歴
        case 11: return listKakugen.count

        // 行動履歴
        case 12: return listAction.count
            
        // 行った場所履歴
        case 13: return listStage.count
            
        default: return 0
            
        }
    }
    
    // セルの内容を変更
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print(NSDate().description, __FUNCTION__, __LINE__)
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        switch tableView.tag {
            
        // 格言履歴
        case 11: cell.textLabel?.text = listKakugen[indexPath.row]
            
        // 行動履歴
        case 12: cell.textLabel?.text = listAction[indexPath.row]
            
        // 行った場所履歴
        case 13: cell.textLabel?.text = listStage[indexPath.row]
            
        default: break
            
        }
        return cell
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
        let listTRefKakugen:[T_RefKakugen] = T_RefKakugen.MR_findByAttribute("charaID", withValue: Const.CHARACTER1_ID, andOrderBy: "kakugenID", ascending: true) as! [T_RefKakugen];
        
        // 格言マスタを全件取得する.（格言IDの昇順）
        let listMKakugen:[M_Kakugen] = M_Kakugen.MR_findAllSortedBy("kakugenID", ascending: true) as! [M_Kakugen];
        
        // 返却するリスト
        var listResult : [String] = []
        
        // ステージマスタを未取得未取得データはマスキングして返却する.
        var refKakugenId = -1
        
        // 格言マスタとキーが一致する場合、名称を返却して終了
        for mKakugenItem in listMKakugen {
            
            for tKakugenItem in listTRefKakugen {
            
                if tKakugenItem.kakugenID == mKakugenItem.kakugenID {
                    
                    //見つかったらワークに退避する.
                    refKakugenId = Int(mKakugenItem.kakugenID)
                }
            
            }

            // 取得済みデータが存在する場合
            if refKakugenId == mKakugenItem.kakugenID {
                
                //取得済みデータはそのままセットする.
                listResult.append(mKakugenItem.kakugenText)
                
            } else {
                
                //未取得データはマスキングしてセットする.
                listResult.append(Const.QUESTION_TEXT)
            }

            // ワークを初期化する.
            refKakugenId = -1
        
        }
        
        // 格言リストを返却する.
        return listResult
    }
 
    //行った場所の履歴の取得
    func getStageHistory() -> [String]  {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        // キャラクターが保有するステージIDを取得する.（ステージIDの昇順）
        let listTRefStage:[T_RefStage] = T_RefStage.MR_findByAttribute("charaID", withValue: Const.CHARACTER1_ID, andOrderBy: "stageID", ascending: true) as! [T_RefStage];
        
        // ステージマスタを全件取得する.（ステージIDの昇順）
        let listMStage:[M_Stage] = M_Stage.MR_findAllSortedBy("stageID", ascending: true) as! [M_Stage];
        
        // 返却するリスト
        var listResult : [String] = []
        
        // ステージマスタを未取得未取得データはマスキングして返却する.
        var refStageId = -1
        
        for mStage in listMStage {
            
            // 取得済み判定.
            for tRefStage in listTRefStage {

                if tRefStage.stageID == mStage.stageID {
                    
                    //見つかったらワークに退避する.
                    refStageId = Int(mStage.stageID)
                }
                
            }

            // 取得済みデータが存在する場合
            if refStageId == mStage.stageID {
                
                //リストにそのままセットする.
                listResult.append(mStage.stageName)
                
            } else {
                
                //未取得データはマスキングしてセットする.
                listResult.append(Const.QUESTION_TEXT)
            }

        // ワークを初期化する.
        refStageId = -1
        
        }
        
        // ステージリストを返却する.
        return listResult
    }

    //行動履歴の取得
    func getActionHistory() -> [String]  {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        // 返却するアイテム
        var listResult :[String] = []
        
        // 取得済アイテムテーブルにアクセスし存在しなければfalseを返却する.
        let actionList :[T_ActionResult] = T_ActionResult.MR_findByAttribute("charaID", withValue: Const.CHARACTER1_ID, andOrderBy: "actSetDate", ascending: true) as! [T_ActionResult];
        
        for action in actionList {
            
            let actStartDate: String = String(action.actStartDate == nil ? "-": action.actStartDate);
            let actEndDate: String = String(action.actEndDate == nil ? "-": action.actEndDate);
            
               listResult.append(
                  String(getM_ItemForKey(Int(action.itemID)).itemName) +  " " + actStartDate +  " " + actEndDate
               )
        }
        
        return  listResult
    }
    
    /** M_ItemからアイテムIDにひもづく取得済アイテム１件の取得 **/
    func getM_ItemForKey(itemId: Int) -> M_Item  {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        // 取得済アイテムテーブルを取得.
        return (M_Item.MR_findByAttribute("itemID", withValue: itemId) as! [M_Item])[0];
        
    }
    
}
