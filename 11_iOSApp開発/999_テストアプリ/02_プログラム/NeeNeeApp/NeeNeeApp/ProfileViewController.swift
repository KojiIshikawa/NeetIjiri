//
//  ProfileViewController.swift
//  NeeNeeApp
//
//  Created by Boil Project on 2016/02/11.
//  Copyright © 2016年 Boil Project. All rights reserved.
//

import Foundation
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


// 履歴書画面です。
class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UIPopoverPresentationControllerDelegate  {

    // 履歴書メニューのオブジェクト
    fileprivate var detailImgView: UIImageView!

    // 履歴書に表示する項目のオブジェクト
    fileprivate var nameDataLabel: UILabel!
    fileprivate var birthDataLabel: UILabel!
    fileprivate var positionDataLabel: UILabel!
    fileprivate var tableViewKakugenHistory: UITableView!
    fileprivate var tableViewActionHistory: UITableView!
    fileprivate var tableViewCompHistory: UITableView!

    //コレクションビューにセットするアイテムリスト
    fileprivate var listStage: [String] = []
    fileprivate var listAction: [String] = []
    fileprivate var listKakugen: [String] = []
    
    // view アンロード開始時
    override func viewWillDisappear(_ animated: Bool) {
        
        // SEを再生する.
        Utility.seSoundPlay(Const.SE_NO_PATH)
    }
    
    // view ロード完了時
    override func viewDidLoad() {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        super.viewDidLoad()

        //背景設定
        detailImgView = UIImageView(frame: self.view.frame)
        detailImgView.image =  Utility.getUncachedImage(named: "02_06_01.png")
        
        // プロフィール設定
        // キャラクター基本情報を取得する.
        let charaData : [T_CharaBase] = Utility.getCharaBase(Const.CHARACTER1_ID)

        // TableViewにセットするデータを取得する.
        listStage = getStageHistory()
        listAction = getActionHistory()
        listKakugen = getKakugenHistory()

        // 名前
        self.nameDataLabel = UILabel()
        self.nameDataLabel.textAlignment = .left
        self.nameDataLabel.text = charaData[0].charaName
        
        //文字数が枠をはみ出す場合は文字を小さくする.
        self.nameDataLabel.font = UIFont.systemFont(ofSize: Utility.getMojiSize(Const.SIZEKBN_MIDDLE))
        
        // 生年月日
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        self.birthDataLabel = UILabel()
        self.birthDataLabel.textAlignment = .left
        self.birthDataLabel.text = dateFormatter.string(from: charaData[0].charaBirth)
        self.birthDataLabel.font = UIFont.systemFont(ofSize: Utility.getMojiSize(Const.SIZEKBN_MIDDLE))

        // 役職
        self.positionDataLabel = UILabel()
        self.positionDataLabel.textAlignment = .left
        self.positionDataLabel.text = getJobName()
        
        //文字数が枠をはみ出す場合は文字を小さくする.
        if self.positionDataLabel.text?.utf16.count > 8 {
            self.positionDataLabel.font = UIFont.systemFont(ofSize: Utility.getMojiSize(Const.SIZEKBN_SMALL))
        } else {
            self.positionDataLabel.font = UIFont.systemFont(ofSize: Utility.getMojiSize(Const.SIZEKBN_MIDDLE))
        }

        // 格言履歴（tableview）
        self.tableViewKakugenHistory = UITableView()
        self.tableViewKakugenHistory.delegate = self
        self.tableViewKakugenHistory.dataSource = self
        self.tableViewKakugenHistory.tag = 11

        // 行動履歴（tableview）
        self.tableViewActionHistory = UITableView()
        self.tableViewActionHistory.delegate = self
        self.tableViewActionHistory.dataSource = self
        self.tableViewActionHistory.allowsSelection = false
        self.tableViewActionHistory.tag = 12
        
        // 行った場所の履歴（tableview）
        self.tableViewCompHistory = UITableView()
        self.tableViewCompHistory.delegate = self
        self.tableViewCompHistory.dataSource = self
        self.tableViewCompHistory.allowsSelection = false
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
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /** 全オブジェクトの制約設定 **/
    func objConstraints() {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        
        detailImgView.translatesAutoresizingMaskIntoConstraints = false
        nameDataLabel.translatesAutoresizingMaskIntoConstraints = false
        birthDataLabel.translatesAutoresizingMaskIntoConstraints = false
        positionDataLabel.translatesAutoresizingMaskIntoConstraints = false
        tableViewKakugenHistory.translatesAutoresizingMaskIntoConstraints = false
        tableViewActionHistory.translatesAutoresizingMaskIntoConstraints = false
        tableViewCompHistory.translatesAutoresizingMaskIntoConstraints = false
        
        // 壁紙の制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.detailImgView,
                attribute:  NSLayoutAttribute.right,
                relatedBy: .equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.right,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.detailImgView,
                attribute: NSLayoutAttribute.bottom,
                relatedBy: .equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.bottom,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.detailImgView,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .width,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.detailImgView,
                attribute: .height,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .height,
                multiplier: 1.0,
                constant: 0
            )]
        )
        
        // 名前の制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.nameDataLabel,
                attribute:  .left,
                relatedBy: .equal,
                toItem: self.view,
                attribute:  .right,
                multiplier: 1.0 / 4.2,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.nameDataLabel,
                attribute: .top,
                relatedBy: .equal,
                toItem: self.view,
                attribute:  .bottom,
                multiplier: 1.0 / 6.4,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.nameDataLabel,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .width,
                multiplier: 1.0 / 2.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.nameDataLabel,
                attribute: .height,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .height,
                multiplier: 1.0 / 20.0,
                constant: 0
            )]
        )

        // 生年月日の制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.birthDataLabel,
                attribute:  .left,
                relatedBy: .equal,
                toItem: self.positionDataLabel,
                attribute:  .left,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.birthDataLabel,
                attribute: .top,
                relatedBy: .equal,
                toItem: self.positionDataLabel,
                attribute:  .bottom,
                multiplier: 1.1 / 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.birthDataLabel,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .width,
                multiplier: 1.0 / 2.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.birthDataLabel,
                attribute: .height,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .height,
                multiplier: 1.0 / 20.0,
                constant: 0
            )]
        )
        
        // 役職の制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.positionDataLabel,
                attribute:  .left,
                relatedBy: .equal,
                toItem: self.nameDataLabel,
                attribute:  .left,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.positionDataLabel,
                attribute: .top,
                relatedBy: .equal,
                toItem: self.nameDataLabel,
                attribute:  .bottom,
                multiplier: 1.15 / 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.positionDataLabel,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .width,
                multiplier: 1.0 / 1.2,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.positionDataLabel,
                attribute: .height,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .height,
                multiplier: 1.0 / 20.0,
                constant: 0
            )]
        )
        
        // 格言履歴の制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.tableViewKakugenHistory,
                attribute:  .left,
                relatedBy: .equal,
                toItem: self.nameDataLabel,
                attribute:  .left,
                multiplier: 0.69 / 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.tableViewKakugenHistory,
                attribute: .top,
                relatedBy: .equal,
                toItem: self.birthDataLabel,
                attribute:  .bottom,
                multiplier: 1.0,
                constant: 10
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.tableViewKakugenHistory,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .width,
                multiplier: 0.78 / 1.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.tableViewKakugenHistory,
                attribute: .height,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .height,
                multiplier: 1.0 / 6.0,
                constant: 0
            )]
        )
        
        // 行動履歴の制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.tableViewActionHistory,
                attribute:  .left,
                relatedBy: .equal,
                toItem: self.tableViewKakugenHistory,
                attribute:  .left,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.tableViewActionHistory,
                attribute: .top,
                relatedBy: .equal,
                toItem: self.tableViewKakugenHistory,
                attribute:  .bottom,
                multiplier: 1.064 / 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.tableViewActionHistory,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.tableViewKakugenHistory,
                attribute: .width,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.tableViewActionHistory,
                attribute: .height,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .height,
                multiplier: 1.0 / 6.1,
                constant: 0
            )]
        )
        
        // 行った場所の制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.tableViewCompHistory,
                attribute:  .left,
                relatedBy: .equal,
                toItem: self.tableViewKakugenHistory,
                attribute:  .left,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.tableViewCompHistory,
                attribute: .top,
                relatedBy: .equal,
                toItem: self.tableViewActionHistory,
                attribute:  .bottom,
                multiplier: 1.03 / 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.tableViewCompHistory,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.tableViewKakugenHistory,
                attribute: .width,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.tableViewCompHistory,
                attribute: .height,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .height,
                multiplier: 1.0 / 5.45,
                constant: 0
            )]
        )
    }
    
    //****************************************
    // MARK: - Table View Delegate
    //****************************************    
    // セルの行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        
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
    
    /** テーブル行選択時の処理 **/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch tableView.tag {
            
            //格言履歴の場合
            case 11:

                //SEを再生する.
                Utility.seSoundPlay(Const.SE_YES_PATH)

                //NSUserDefaultに格言表示日付をセットする.
                let ud = UserDefaults.standard
                
                //セッションに選択行の格言を書き込み.
                ud.setValue(listKakugen[(indexPath as NSIndexPath).row], forKey: "KAKUGEN_LOG_STRING")
                ud.synchronize()
                
                //行選択を解除する.
                tableViewKakugenHistory.deselectRow(at: indexPath, animated: true)
                
                //ポップアップを表示する.
                self.showPopoverView(self.tableViewKakugenHistory, identifier: "KakugenView")
            return
            
        default: return
            
        }
    }
    
    //Popover表示
    func showPopoverView(_ sender: AnyObject, identifier:String) {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        let popoverView = self.storyboard!.instantiateViewController(withIdentifier: identifier) as UIViewController
        popoverView.modalPresentationStyle = .popover
        popoverView.preferredContentSize = CGSize(width: self.view.bounds.width / 1.0, height: self.view.bounds.height / 1.0)
        popoverView.view.backgroundColor = UIColor.clear
        if let presentationController = popoverView.popoverPresentationController {
            presentationController.permittedArrowDirections = .down
            presentationController.sourceView = sender as! UITableView
            presentationController.sourceRect = sender.bounds
            presentationController.delegate = self
            //presentationController.popoverBackgroundViewClass = PopoverBackgroundView.classForCoder()
        }
        popoverView.title = identifier
        self.present(popoverView, animated: true, completion:nil)
        
    }
    
    //Popover実装時に必要になるイベント　おまじない
    func adaptivePresentationStyle(for controller: UIPresentationController)
        -> UIModalPresentationStyle {
            return .none
    }
    
    //popOver表示終了後のイベント
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
    }

    
    // セルの内容を変更
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
        
        switch tableView.tag {
            
        // 格言履歴
        case 11:
            cell.textLabel?.text = listKakugen[(indexPath as NSIndexPath).row]
            cell.textLabel!.font = UIFont.systemFont(ofSize: Utility.getMojiSize(Const.SIZEKBN_MIDDLE))
        // 行動履歴
        case 12:
            cell.textLabel?.text = listAction[(indexPath as NSIndexPath).row]
            cell.textLabel!.font = UIFont.systemFont(ofSize: Utility.getMojiSize(Const.SIZEKBN_SMALL))
        // 行った場所履歴
        case 13:
            cell.textLabel?.text = listStage[(indexPath as NSIndexPath).row]
            cell.textLabel!.font = UIFont.systemFont(ofSize: Utility.getMojiSize(Const.SIZEKBN_MIDDLE))
        default:
            break
            
        }
        return cell
    }
    
    //****************************************
    // MARK: - DB Access
    //****************************************
    
    //役職名の取得
    func getJobName() -> String  {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        
        // キャラクターIDが一致する最大のジョブIDを取得する.
        let tRefJob:[T_RefJob] = T_RefJob.mr_find(byAttribute: "charaID", withValue: Const.CHARACTER1_ID, andOrderBy: "jobID", ascending: false) as! [T_RefJob];
        
        // 役職マスタを全件取得する.
        let mJob:[M_Job] = M_Job.mr_findAll() as! [M_Job];

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
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        
        // キャラクターが保有する格言IDを取得する.（格言IDの昇順）
        let listTRefKakugen:[T_RefKakugen] = T_RefKakugen.mr_find(byAttribute: "charaID", withValue: Const.CHARACTER1_ID, andOrderBy: "kakugenID", ascending: true) as! [T_RefKakugen];
        
        // 格言マスタを全件取得する.（格言IDの昇順）
        let listMKakugen:[M_Kakugen] = M_Kakugen.mr_findAllSorted(by: "kakugenID", ascending: true) as! [M_Kakugen];
        
        // 返却するリスト
        var listResult : [String] = []
        
        // ステージマスタを未取得する.なお未取得データはマスキングして返却する.
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
            if Int(refKakugenId) == Int(mKakugenItem.kakugenID) {
                
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
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        
        // キャラクターが保有するステージIDを取得する.（ステージIDの昇順）
        let listTRefStage:[T_RefStage] = T_RefStage.mr_find(byAttribute: "charaID", withValue: Const.CHARACTER1_ID, andOrderBy: "stageID", ascending: true) as! [T_RefStage];
        
        // ステージマスタを全件取得する.（ステージIDの昇順）
        let listMStage:[M_Stage] = M_Stage.mr_findAllSorted(by: "stageID", ascending: true) as! [M_Stage];
        
        // 返却するリスト
        var listResult : [String] = []
        
        // ステージマスタを未取得データはマスキングして返却する.
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
            if Int(refStageId) == Int(mStage.stageID) {
                
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
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        
        // 返却するアイテム
        var listResult :[String] = []
        
        // 取得済アイテムテーブルにアクセスし存在しなければfalseを返却する.
        let actionList :[T_ActionResult] = T_ActionResult.mr_find(byAttribute: "charaID", withValue: Const.CHARACTER1_ID, andOrderBy: "actSetDate", ascending: true) as! [T_ActionResult];
        
        for action in actionList {
            
            let actStartDate: String
              = action.actStartDate == nil ? "-": Utility.jpDate(action.actStartDate);
            let actEndDate: String
              = action.actEndDate == nil ? "-": Utility.jpDate(action.actEndDate);
            
            if actStartDate == "-" && actEndDate == "-" {

                //準備中の場合
                listResult.append(
                    String(Utility.getMItem(Int(action.itemID))[0].itemName) +  " " + "（じゅんびちゅう...）"
                )
            } else if actEndDate == "-" {

                //実行中の場合
                listResult.append(
                    String(Utility.getMItem(Int(action.itemID))[0].itemName) +  " " + actStartDate +  " 〜 " + "（つぶしちゅう...）"
                )
            } else {

                //完了済みの場合
                listResult.append(
                    String(Utility.getMItem(Int(action.itemID))[0].itemName) +  " " + actStartDate +  " 〜 " + actEndDate
                )
                
            }
            
        }
        
        return  listResult
    }
}
