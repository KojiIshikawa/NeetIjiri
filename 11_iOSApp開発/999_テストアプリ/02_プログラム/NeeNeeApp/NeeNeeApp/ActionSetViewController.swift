//
//  ActionSetViewController.swift
//  NeeNeeApp
//
//  Created by v2_system on 2016/02/07.
//  Copyright © 2016年 KojiIshikawa. All rights reserved.
//

import UIKit
import iAd
import AVFoundation

//暇つぶしをセットする画面です。
class ActionSetViewController: UIViewController, AVAudioPlayerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIGestureRecognizerDelegate,UIPopoverPresentationControllerDelegate  {
    
    // 暇つぶしメニューのオブジェクト
    private var itemCollectionView: UICollectionView!
    private var setItemView: UIImageView!
    private var selItemView: UIImageView!
    private var mainImgView: UIImageView!
    
    // 背景画像用オブジェクト
    private let mainViewImage = UIImage(named: "02_01_01.png")
    private var touchesPosition = CGPoint!()
    private let mySeSetPath = NSBundle.mainBundle().pathForResource("se1", ofType:"mp3")
    
    
    //コレクションビューにセットするアイテムリスト
    private var itemList: [Dictionary <String,String>] = []
    private var itemListIdx: Int = 0
    
    override func viewDidLoad() {
        
        mainImgView = UIImageView()
        mainImgView.frame.size = self.view.frame.size
        
        // ポップの背景を設定する.
        mainImgView.image = mainViewImage
        mainImgView.alpha = 0.9

        // セット済みアイテムの初期設定.
        setItemView = UIImageView()
        setItemImageReLoad()
        
        // 画像をUIImageViewに設定する.
        let myImage = self.getUncachedImage( named: "02_01_01.png")
        mainImgView.image = myImage
        
        // CollectionViewのレイアウトを生成.
        let layout = UICollectionViewFlowLayout()
        
        // Cell一つ一つの大きさ.
        layout.itemSize = CGSizeMake(100, 100)
        /**
        // Cellのマージン.
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        // セクション毎のヘッダーサイズ.
        layout.headerReferenceSize = CGSizeMake(0,0)
        **/
        // 横スクロール
        layout.scrollDirection = .Horizontal
        itemCollectionView = UICollectionView(frame: CGRectMake(0,0,0,0), collectionViewLayout: layout)
        itemCollectionView.registerClass(itemCell.self, forCellWithReuseIdentifier: "cell")
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        
        // アイテムリストを取得し、メンバ変数にセット
        itemList = getT_GetItem()
        
        // セル長押しイベント登録
        let longTapRecognizer = UILongPressGestureRecognizer(target: self, action: "cellLongTap:")
        longTapRecognizer.delegate = self
        //itemCollectionView.userInteractionEnabled = false
        itemCollectionView.addGestureRecognizer(longTapRecognizer)
    
        /**
        let tap = UITapGestureRecognizer(target: self, action : "handleTap:")
        tap.numberOfTapsRequired = 1
        itemCollectionView.addGestureRecognizer(tap)
        **/

        // ポップ上に表示するオブジェクトをViewに追加する.
        view.addSubview(mainImgView)
        view.addSubview(setItemView)
        view.addSubview(itemCollectionView)

        // 制約を設定する.
        objConstraints()
    }
    
    override func didReceiveMemoryWarning() {
    }

    //****************************************
    // MARK: - イベント
    //****************************************
    
    // 画面ドラッグで呼ばれる
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

        print(NSDate().description, __FUNCTION__, __LINE__)
        
    }
    
    
    // 画面ドラッグで呼ばれる
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        print(NSDate().description, __FUNCTION__, __LINE__)
        print("外で離した")

        
    }
    
    /** 暇つぶしアイテム長押し時の処理 **/
    func cellLongTap(recognizer: UILongPressGestureRecognizer) {
        print(NSDate().description, __FUNCTION__, __LINE__)
        print("長押し")
        
        // 押された位置でcellのPathを取得
        let point = recognizer.locationInView(itemCollectionView)
        
        let indexPath = self.itemCollectionView.indexPathForItemAtPoint(point)

        if recognizer.state == UIGestureRecognizerState.Began  {
            
            // 長押しされた場合の処理
            print("長押しされたcellのindexPath:\(indexPath?.row)")

            // タップされたアイテムの画像を半透明で表示する
            let myImage = self.getUncachedImage( named: "06_01_01.png")
            
            // 選択中表示用アイテムが未作成なら作成する.
            if selItemView == nil {
                
                selItemView = UIImageView()
                selItemView.image = myImage
                selItemView.alpha = 0.8
                selItemView.frame.size = CGSizeMake(100,100)
                self.view.addSubview(selItemView)
            }
            
            print(recognizer.state)
        
        } else if recognizer.state == UIGestureRecognizerState.Ended  {
            
            print("離した")
            
            // セットアイテムの領域内の場合
            if recognizer.locationInView(self.view).x <= setItemView.frame.maxX
            && recognizer.locationInView(self.view).x >= setItemView.frame.origin.x
            && recognizer.locationInView(self.view).y <= setItemView.frame.maxY
            && recognizer.locationInView(self.view).y >= setItemView.frame.origin.y {
                
                // 領域内の場合、セットアイテムをセットする.
                setItemImageReLoad()
                
                // セットアイテムをデータベースに書き込む.
                let idx : Int = (indexPath?.row)!
                let stringNumber : String = String(UTF8String: itemList[idx]["itemName"]!)!
                insertT_ActionResultWithActive(Int(stringNumber)!)
                print("セットされたアイテムのアイテムコード：" + stringNumber)
            }

            // 選択中アイテムのイメージを破棄する.
            selItemView.removeFromSuperview()
            selItemView = nil
            
        }
        
        // 画像がある場合は画像位置を移動
        if selItemView != nil {
            
            // 選択したアイテムの画像位置をタップ中の位置に常に合わせる.
            selItemView.frame.origin.x = recognizer.locationInView(self.view).x
            selItemView.frame.origin.y = recognizer.locationInView(self.view).y
            selItemView.frame.origin.x -= 40.0
            selItemView.frame.origin.y -= 40.0
            
        }
    }
    
    //****************************************
    // MARK: - Collection View Delegate
    //****************************************
    
    // Cellが選択された際に呼び出される
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        print("Num: \(indexPath.row)")
        
    }
    
    /** セクションの数 **/
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        print(NSDate().description, __FUNCTION__, __LINE__)
        return 1
    }
    
    /** 表示するセルの数 **/
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(NSDate().description, __FUNCTION__, __LINE__)
        return itemList.count
    }
    
    /** セルが表示されるときに呼ばれる処理（1個のセルを描画する毎に呼び出されます） **/
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! itemCell
        
        // セルの情報を設定する.
        cell._name.text = itemList[itemListIdx]["itemName"]! + " ×" + itemList[itemListIdx]["itemCountValue"]!
        cell._img.image = self.getUncachedImage( named: itemList[itemListIdx]["imageItem"]!)
        
        // アイテムリストのインデックスをカウントアップする.
        itemListIdx += 1
        
        // セルを返却する.
        return cell
    }

    //****************************************
    // MARK: - その他メソッド
    //****************************************
    func getUncachedImage (named name : String) -> UIImage?
    {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        if let imgPath = NSBundle.mainBundle().pathForResource(name, ofType: nil)
        {
            return UIImage(contentsOfFile: imgPath)
        }
        return nil
    }
    
    /** 全オブジェクトの制約設定 **/
    func objConstraints() {
        print(NSDate().description, __FUNCTION__, __LINE__)
   
        itemCollectionView.translatesAutoresizingMaskIntoConstraints = false
        setItemView.translatesAutoresizingMaskIntoConstraints = false

        // セットアイテムメニューの制約
        self.view.addConstraints([

            // x座標
            NSLayoutConstraint(
                item: self.setItemView,
                attribute:  NSLayoutAttribute.CenterX,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.CenterX,
                multiplier: 1.0,
                constant: 0
            ),

            // y座標
            NSLayoutConstraint(
                item: self.setItemView,
                attribute: NSLayoutAttribute.Top,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 100
            ),

            // 横幅
            NSLayoutConstraint(
                item: self.setItemView,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0 / 2.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.setItemView,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0 / 3.0,
                constant: 0
            )]
        )
        // コレクションビューの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.itemCollectionView,
                attribute:  NSLayoutAttribute.CenterX,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.CenterX,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.itemCollectionView,
                attribute: NSLayoutAttribute.Top,
                relatedBy: .Equal,
                toItem: self.setItemView,
                attribute:  NSLayoutAttribute.Bottom,
                multiplier: 1.0,
                constant: 60
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.itemCollectionView,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0,
                constant: -20
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.itemCollectionView,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: nil,
                attribute: .Height,
                multiplier: 1.0,
                constant: 100
            )]
        )
    }

    /** セット済みアイテムの円グラフを再描画する. **/
    func setItemImageReLoad ()
    {
        
        // 行動実績テーブルを読み込み、未実行または実行中のアクション数に合わせ、円グラフの画像を設定する.
        switch getT_ActionResultWithActive().count {
            
        case 0:
            setItemView.image = self.getUncachedImage( named: "02_05_01.png")
            break
        case 1:
            setItemView.image = self.getUncachedImage( named: "02_05_02.png")
            break
        case 2:
            setItemView.image = self.getUncachedImage( named: "02_05_03.png")
            break
        case 3:
            setItemView.image = self.getUncachedImage( named: "02_05_04.png")
            break
        default:
            
            // エラーダイアログを表示
            let alertController = UIAlertController(title: "忙しすぎて死んじゃう"
                , message: "未実行のひまをキャンセルしてください。", preferredStyle: .Alert)
            let defaultActionYes = UIAlertAction(title: "OK", style: .Default, handler:nil)
            alertController.addAction(defaultActionYes)
            presentViewController(alertController, animated: true, completion: nil)
            
        }
    }
    
    //****************************************
    // MARK: - DB Access
    //****************************************
    
    /** 未実行・実行中のアクティブなアイテムの取得 **/
    func getT_ActionResultWithActive() -> [T_ActionResult]  {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        // 返却するアイテム
        var actionList :[T_ActionResult] = []
        
        // 取得済アイテムテーブルにアクセスし存在しなければfalseを返却する.
        let tempList :[T_ActionResult] = T_ActionResult.MR_findByAttribute("charaID", withValue: Const.CHARACTER1_ID, andOrderBy: "actStartDate,actEndDate", ascending: true) as! [T_ActionResult];
        print(actionList.count)
        
        for temp in tempList {
            
            // 実行中または未実行のデータをセットする.
            if temp.actEndDate == nil {
                
                actionList.insert(temp, atIndex: actionList.count)
            } else {
                continue
            }
            
        }
        
        return  actionList
    }

    /** 未実行・実行中のアクティブなアイテムの追加 **/
    func insertT_ActionResultWithActive(itemId: Int) {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        // 指定されたアイテムをテーブルに行動実績テーブルに追加.
        let insetData = T_ActionResult.MR_createEntity()! as T_ActionResult
        insetData.itemID = itemId
        insetData.actSetDate = NSDate()
        insetData.managedObjectContext!.MR_saveToPersistentStoreAndWait()
        
        // 取得済アイテムマスタの所持数をもとに戻す.
        // TODO: 所持数を加算する（未実装）
    }
    
    /** 未実行・実行中のアクティブなアイテムの削除 **/
    func deleteT_ActionResultWithActive(deleteData: T_ActionResult) {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        // 指定されたアイテムをに行動実績テーブルから削除.
        deleteData.MR_deleteEntity()
        deleteData.managedObjectContext!.MR_saveToPersistentStoreAndWait()
        
        // 取得済アイテムマスタの所持数をもとに戻す.
        // TODO: 所持数を加算する（未実装）
    }
    
    /** T_GetItemから取得済アイテムの取得 **/
    func getT_GetItem() -> [Dictionary<String, String>]  {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        // 取得済アイテムテーブルを取得.
        let itemTList :[T_GetItem] = T_GetItem.MR_findByAttribute("charaID", withValue: Const.CHARACTER1_ID, andOrderBy: "itemId", ascending: true) as! [T_GetItem];
        
        //返却するアイテムリスト
        var itemList : [Dictionary<String, String>] = []
        
        // アイテムマスタを取得.
        let itemMList :[M_Item] = M_Item.MR_findAllSortedBy("itemId", ascending: true) as! [M_Item];
        
        for havingItem in itemTList {

            for masterItem in itemMList {
                
                // 一致する場合、アイテム情報セットする.
                if havingItem.itemID == masterItem.itemID {

                    // アイテムをセット
                    var itemDic : Dictionary<String, String> = Dictionary<String, String>()
                    itemDic["itemID"] = String(havingItem.itemID)
                    itemDic["itemCountValue"] = String(havingItem.itemCountValue)
                    itemDic["itemName"] = String(masterItem.itemName)
                    itemDic["itemText"] = String(masterItem.itemText)
                    itemDic["imageItem"] = String(masterItem.imageItem)
                    itemList.append(itemDic)
                }

            }
        }
        
        //作成したアイテムリストを返却
        return  itemList
    }
}