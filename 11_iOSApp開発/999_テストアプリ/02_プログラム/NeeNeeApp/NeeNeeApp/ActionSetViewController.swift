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

    // セット中のアイテム情報ラベル
    private var selItemLabel1: UILabel!
    private var selItemLabel2: UILabel!
    private var selItemLabel3: UILabel!
    
    //コレクションビューにセットするアイテムリスト
    private var itemList: [Dictionary <String,String>] = []
    private var itemListIdxPath: Int = -1
    
    //取得済みセットアクションリスト
    private var listActiveAction:[T_ActionResult] = []
    
    override func viewDidLoad() {
        
        // ポップの背景を設定する.
        mainImgView = UIImageView(frame: self.view.frame)
        mainImgView.image = Utility.getUncachedImage(named: "02_01_01.png")

        // セット中アイテムラベルの生成.
        selItemLabel1 = UILabel()
        selItemLabel2 = UILabel()
        selItemLabel3 = UILabel()
        
        // 仮で設定
        selItemLabel1.sizeToFit()
        selItemLabel2.sizeToFit()
        selItemLabel3.sizeToFit()

        selItemLabel1.numberOfLines = 2
        selItemLabel2.numberOfLines = 2
        selItemLabel3.numberOfLines = 2
        
        // セット済みアイテムの初期設定.
        setItemView = UIImageView()
        
        // 長押しイベント登録.
        selItemLabel1.tag = 11
        selItemLabel2.tag = 12
        selItemLabel3.tag = 13
        
        selItemLabel1.userInteractionEnabled = true
        selItemLabel2.userInteractionEnabled = true
        selItemLabel3.userInteractionEnabled = true
        
        let setItem1LongTouchRecognizer = UILongPressGestureRecognizer(target: self, action: "setItemLongTouch:")
        setItem1LongTouchRecognizer.minimumPressDuration = 0.2
        setItem1LongTouchRecognizer.delegate = self
        selItemLabel1.addGestureRecognizer(setItem1LongTouchRecognizer)
        
        let setItem2LongTouchRecognizer = UILongPressGestureRecognizer(target: self, action: "setItemLongTouch:")
        setItem2LongTouchRecognizer.minimumPressDuration = 0.2
        setItem2LongTouchRecognizer.delegate = self
        selItemLabel2.addGestureRecognizer(setItem2LongTouchRecognizer)
        
        let setItem3LongTouchRecognizer = UILongPressGestureRecognizer(target: self, action: "setItemLongTouch:")
        setItem3LongTouchRecognizer.minimumPressDuration = 0.2
        setItem3LongTouchRecognizer.delegate = self
        selItemLabel3.addGestureRecognizer(setItem3LongTouchRecognizer)
        
        // CollectionViewのレイアウトを生成.
        let layout = UICollectionViewFlowLayout()

        // Cell一つ一つの大きさを設定.
        layout.itemSize = CGSizeMake(
            CGFloat(self.view.frame.height / 6.8)
            , CGFloat(self.view.frame.height / 6.8))
        
        //NSUserDefaultにアクションセット画面のサイズを保存
        let ud1 = NSUserDefaults.standardUserDefaults()
        ud1.setFloat(Float(CGFloat(self.view.frame.height / 6.8)), forKey: "ACTIONSET_SIZE")
        ud1.synchronize()
        
        // 横スクロール
        layout.scrollDirection = .Horizontal
        itemCollectionView = UICollectionView(frame: CGRectMake(0,0,0,0), collectionViewLayout: layout)
        itemCollectionView.registerClass(itemCell.self, forCellWithReuseIdentifier: "cell")
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        
        // セットアイテムの再描画.
        setItemImageReLoad()
        
        // セル長押しイベント登録
        // 長押し用レコグナイザー
        let cellitemCellLongTouchRecognizer = UILongPressGestureRecognizer(target: self, action: "itemCellLongTouch:")
        cellitemCellLongTouchRecognizer.minimumPressDuration = 0.2
        cellitemCellLongTouchRecognizer.delegate = self
        itemCollectionView.addGestureRecognizer(cellitemCellLongTouchRecognizer)

        // ポップ上に表示するオブジェクトをViewに追加する.
        view.addSubview(mainImgView)
        view.addSubview(setItemView)
        view.addSubview(itemCollectionView)
        view.addSubview(selItemLabel1)
        view.addSubview(selItemLabel2)
        view.addSubview(selItemLabel3)
        
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

        print(NSDate().description, NSStringFromClass(self.classForCoder), __FUNCTION__, __LINE__)
        
    }
    
    
    // 画面ドラッグで呼ばれる
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        print(NSDate().description, NSStringFromClass(self.classForCoder), __FUNCTION__, __LINE__)
        
    }

    /** 暇つぶしアイテム長押し時の処理 **/
    func setItemLongTouch(recognizer: UILongPressGestureRecognizer) {
        print(NSDate().description, NSStringFromClass(self.classForCoder), __FUNCTION__, __LINE__)

        switch recognizer.state {
            
            //長押し-タッチ時の処理
        case UIGestureRecognizerState.Began:
            
            // 画像に使用するアイテムID
            var picItemID:Int = 0
            
            switch Int((recognizer.view?.tag)!) {
            case 11:
                
                // セットアイテム１の場合
                // セットアイテムが存在する場合、セット
                picItemID = listActiveAction.count >= 1 ? Int(listActiveAction[0].itemID) : 0
                
            case 12:
                
                // セットアイテム２の場合
                // セットアイテムが存在する場合、セット
                picItemID = listActiveAction.count >= 2 ? Int(listActiveAction[1].itemID) : 0
                
                
            default:
                
                // セットアイテム３の場合
                // セットアイテムが存在する場合、セット
                picItemID = listActiveAction.count >= 3 ? Int(listActiveAction[2].itemID) : 0
                
                break
                
            }
            
            // アイテムが取得できた場合
            if picItemID > 0 {
                
                // タップされたアイテムの画像を半透明で表示する.
                let myImage = Utility.getUncachedImage( named: String(UTF8String: getM_ItemForKey(Int(picItemID)).imageItem)!)!
                
                
                // 選択中表示用アイテムが未作成なら作成する.
                if selItemView == nil {
                    
                    selItemView = UIImageView()
                    selItemView.image = myImage
                    selItemView.alpha = 0.8
                    selItemView.frame.size = CGSizeMake(100,100)
                    self.view.addSubview(selItemView)
                }
            }
            
            //長押し-指を離した時の処理
        case UIGestureRecognizerState.Ended:
            
            // セットアイテムの領域内の場合
            if recognizer.locationInView(self.view).x <= itemCollectionView.frame.maxX
                && recognizer.locationInView(self.view).x >= itemCollectionView.frame.origin.x
                && recognizer.locationInView(self.view).y <= itemCollectionView.frame.maxY
                && recognizer.locationInView(self.view).y >= itemCollectionView.frame.origin.y {
                    
                    switch Int((recognizer.view?.tag)!) {
                    case 11:
                        
                        // セットアイテム１の場合
                        if cancelItemActiveChk() {

                            // セットアイテム１をアクションテーブルから削除する.
                            deleteT_ActionResultWithActive(listActiveAction[0])
                            
                            // SEを再生する.
                            Utility.seSoundPlay(Const.mySeItemCancelNoPath)
                            
                        } else {

                            // SEを再生する.
                            Utility.seSoundPlay(Const.mySeItemSetNGPath)

                        }
                        
                    case 12:
                        
                        // セットアイテム２の場合
                        // セットアイテム２をアクションテーブルから削除する.
                        deleteT_ActionResultWithActive(listActiveAction[1])

                        // SEを再生する.
                        Utility.seSoundPlay(Const.mySeItemCancelNoPath)
                        
                    default:
                        
                        // セットアイテム３の場合
                        // セットアイテム３をアクションテーブルから削除する.
                        deleteT_ActionResultWithActive(listActiveAction[2])
                        
                        // SEを再生する.
                        Utility.seSoundPlay(Const.mySeItemCancelNoPath)
                        break
                        
                    }
                    
            }
            
            // 選択中アイテムのイメージを破棄する.
            selItemView.removeFromSuperview()
            selItemView = nil
            
            // セットアイテムの再描画.
            setItemImageReLoad()
            
        default: break
            
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
    
    /** 暇つぶしアイテム長押し時の処理 **/
    func itemCellLongTouch(recognizer: UILongPressGestureRecognizer) {
        print(NSDate().description, NSStringFromClass(self.classForCoder), __FUNCTION__, __LINE__)
        
        switch recognizer.state {
            
          //長押し-タッチ時の処理
          case UIGestureRecognizerState.Began:
        
            // 押された位置でcellのPathを取得する.
            let point = recognizer.locationInView(itemCollectionView)
            
            // 選択されたアイテムをメンバ変数に保持しておく.
            itemListIdxPath = self.itemCollectionView.indexPathForItemAtPoint(point) == nil
                ? -1 : (self.itemCollectionView.indexPathForItemAtPoint(point)?.row)!
            
            // 長押しされた場合の処理
            // アイテムが選択されている場合のみ処理する.
            if itemListIdxPath > -1 {
            
                // タップされたアイテムの画像を半透明で表示する
                let myImage = Utility.getUncachedImage( named: String(UTF8String: itemList[itemListIdxPath]["imageItem"]!)!)
            
                // 選択中表示用アイテムが未作成なら作成する.
                if selItemView == nil {
                
                    selItemView = UIImageView()
                    selItemView.image = myImage
                    selItemView.alpha = 0.8
                    selItemView.frame.size = CGSizeMake(100,100)
                    self.view.addSubview(selItemView)
                }
                
            }
            
          //長押し-指を離した時の処理
          case UIGestureRecognizerState.Ended:
            
            // セットアイテムの領域内の場合
            if recognizer.locationInView(self.view).x <= setItemView.frame.maxX
                && recognizer.locationInView(self.view).x >= setItemView.frame.origin.x
                && recognizer.locationInView(self.view).y <= setItemView.frame.maxY
                && recognizer.locationInView(self.view).y >= setItemView.frame.origin.y {
                    
                    // アイテムが選択されている場合のみ処理する.
                    if itemListIdxPath > -1 {
                        
                        // セットアイテムの再描画.
                        if setItemOverChk() {
                            
                            // SEを再生する.
                            Utility.seSoundPlay(Const.mySeItemSetPath)

                            // セットアイテムをデータベースに書き込む.
                            insertT_ActionResultWithActive(Int(itemList[itemListIdxPath]["itemID"]!)!)
                            
                            // 画面を再描画する.
                            setItemImageReLoad()
                            
                        } else {
                            
                            // SEを再生する.
                            Utility.seSoundPlay(Const.mySeItemSetNGPath)
                        }
                        
                    }
            }
            
            if (selItemView != nil) {

                // 選択中アイテムのイメージを破棄する.
                selItemView.removeFromSuperview()
                selItemView = nil
                
            }
            
            
        default: break
            
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
        print(NSDate().description, NSStringFromClass(self.classForCoder), __FUNCTION__, __LINE__)
        
    }
    
    /** セクションの数 **/
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        print(NSDate().description, NSStringFromClass(self.classForCoder), __FUNCTION__, __LINE__)
        return 1
    }
    
    /** 表示するセルの数 **/
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(NSDate().description, NSStringFromClass(self.classForCoder), __FUNCTION__, __LINE__)
        return itemList.count
    }
    
    /** セルが表示されるときに呼ばれる処理（1個のセルを描画する毎に呼び出されます） **/
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        print(NSDate().description, NSStringFromClass(self.classForCoder), __FUNCTION__, __LINE__)
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! itemCell
        
        // セルの情報を設定する.
        cell._name.text = itemList[indexPath.row]["itemName"]! + " ×" + itemList[indexPath.row]["itemCountValue"]!
        cell._img.image = Utility.getUncachedImage( named: itemList[indexPath.row]["imageItem"]!)
        
        // セルを返却する.
        return cell
    }

    //****************************************
    // MARK: - その他メソッド
    //****************************************
    
    /** 全オブジェクトの制約設定 **/
    func objConstraints() {
        print(NSDate().description, NSStringFromClass(self.classForCoder), __FUNCTION__, __LINE__)
   
        mainImgView.translatesAutoresizingMaskIntoConstraints = false
        selItemLabel1.translatesAutoresizingMaskIntoConstraints = false
        selItemLabel2.translatesAutoresizingMaskIntoConstraints = false
        selItemLabel3.translatesAutoresizingMaskIntoConstraints = false
        itemCollectionView.translatesAutoresizingMaskIntoConstraints = false
        setItemView.translatesAutoresizingMaskIntoConstraints = false

        
        // 壁紙の制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.mainImgView,
                attribute:  NSLayoutAttribute.Right,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.Right,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.mainImgView,
                attribute: NSLayoutAttribute.Bottom,
                relatedBy: .Equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.Bottom,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.mainImgView,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.mainImgView,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0,
                constant: 0
            )]
        )
        
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
                attribute:  NSLayoutAttribute.Bottom,
                multiplier: 1.0 / 8.0,
                constant: 0
            ),

            // 横幅
            NSLayoutConstraint(
                item: self.setItemView,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0 / 1.8,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.setItemView,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0 / 2.6,
                constant: 0
            )]
        )
        
        // セットアイテムラベル３の制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.selItemLabel3,
                attribute:  NSLayoutAttribute.Left,
                relatedBy: .Equal,
                toItem: self.setItemView,
                attribute:  NSLayoutAttribute.Left,
                multiplier: 1.0 / 1.6,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.selItemLabel3,
                attribute: NSLayoutAttribute.Top,
                relatedBy: .Equal,
                toItem: self.setItemView,
                attribute:  NSLayoutAttribute.Top,
                multiplier: 1.5 / 1.0,
                constant: 0
            )]
        )

        // セットアイテムラベル２の制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.selItemLabel2,
                attribute:  NSLayoutAttribute.CenterX,
                relatedBy: .Equal,
                toItem: self.setItemView,
                attribute:  NSLayoutAttribute.CenterX,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.selItemLabel2,
                attribute: NSLayoutAttribute.Top,
                relatedBy: .Equal,
                toItem: self.setItemView,
                attribute:  NSLayoutAttribute.Bottom,
                multiplier: 1.0 / 1.05,
                constant: 0
            )]
        )

        // セットアイテムラベル１の制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.selItemLabel1,
                attribute:  NSLayoutAttribute.Right,
                relatedBy: .Equal,
                toItem: self.setItemView,
                attribute:  NSLayoutAttribute.Right,
                multiplier: 1.2 / 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.selItemLabel1,
                attribute: NSLayoutAttribute.Top,
                relatedBy: .Equal,
                toItem: self.setItemView,
                attribute:  NSLayoutAttribute.Top,
                multiplier: 1.5 / 1.0,
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
                multiplier: 1.2 / 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.itemCollectionView,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0 / 1.2,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.itemCollectionView,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0 / 5.0,
                constant: 0
            )]
        )
    }

    /** セット済みアイテムの上限チェック. **/
    func setItemOverChk() -> DarwinBoolean
    {
        
        // 行動実績テーブルを読み込み、アクティブなアクションを取得する.
        listActiveAction = []
        listActiveAction = getT_ActionResultWithActive()
        
        // 未実行または実行中のアクション数に合わせ、円グラフの画像、テキストを設定する.
        if (listActiveAction.count >= 3) {

            // エラーダイアログを表示
            let alertController = UIAlertController(title: "忙しすぎて死んじゃうよ"
                , message: "未実行のひまをキャンセルしてください。", preferredStyle: .Alert)
            let defaultActionYes = UIAlertAction(title: "OK", style: .Default, handler:nil)
            alertController.addAction(defaultActionYes)
            presentViewController(alertController, animated: true, completion: nil)
            return false
            
        }
        
        // エラーフラグを返却する.
        return true
    }
    
    /** 実行中アイテムのキャンセル可否チェック. **/
    func cancelItemActiveChk() -> DarwinBoolean
    {
        
        // 行動実績テーブルを読み込み、アクティブなアクションを取得する.
        listActiveAction = []
        listActiveAction = getT_ActionResultWithActive()
        
        // 未実行または実行中のアクション数に合わせ、円グラフの画像、テキストを設定する.
        if (listActiveAction.count >= 1 &&
            listActiveAction[0].actStartDate != nil) {
                
                // エラーダイアログを表示
                let alertController = UIAlertController(title: "つぶしてるとちゅうだよ"
                    , message: "ひまつぶし中のひまはキャンセルできません。", preferredStyle: .Alert)
                let defaultActionYes = UIAlertAction(title: "OK", style: .Default, handler:nil)
                alertController.addAction(defaultActionYes)
                presentViewController(alertController, animated: true, completion: nil)
                return false
                
        }
        
        // エラーフラグを返却する.
        return true
    }
    
    /** セット済みアイテムの円グラフを再描画する. **/
    func setItemImageReLoad() -> DarwinBoolean
    {
    
        // アイテムリストを取得し、メンバ変数にセットする.
        itemList = getT_GetItem()
        
        // コレクションビューをリロードする.
        itemCollectionView.reloadData()
        
        // 行動実績テーブルを読み込み、アクティブなアクションを取得する.
        listActiveAction = []
        listActiveAction = getT_ActionResultWithActive()
        
        // 未実行または実行中のアクション数に合わせ、円グラフの画像、テキストを設定する.
        switch listActiveAction.count {

        case 0:
            setItemView.image = Utility.getUncachedImage( named: "02_05_01.png")
            selItemLabel1.text = ""
            selItemLabel2.text = ""
            selItemLabel3.text = ""
            selItemLabel1.hidden = true
            selItemLabel2.hidden = true
            selItemLabel3.hidden = true
            break
        case 1:
            setItemView.image = Utility.getUncachedImage( named: "02_05_02.png")
            selItemLabel1.text = getM_ItemForKey(Int(listActiveAction[0].itemID)).itemName
            selItemLabel2.text = ""
            selItemLabel3.text = ""
            selItemLabel1.hidden = false
            selItemLabel2.hidden = true
            selItemLabel3.hidden = true
            break
        case 2:
            setItemView.image = Utility.getUncachedImage( named: "02_05_03.png")
            selItemLabel1.text = getM_ItemForKey(Int(listActiveAction[0].itemID)).itemName
            selItemLabel2.text = getM_ItemForKey(Int(listActiveAction[1].itemID)).itemName
            selItemLabel3.text = ""
            selItemLabel1.hidden = false
            selItemLabel2.hidden = false
            selItemLabel3.hidden = true
            break
        case 3:
            setItemView.image = Utility.getUncachedImage( named: "02_05_04.png")
            selItemLabel1.text = getM_ItemForKey(Int(listActiveAction[0].itemID)).itemName
            selItemLabel2.text = getM_ItemForKey(Int(listActiveAction[1].itemID)).itemName
            selItemLabel3.text = getM_ItemForKey(Int(listActiveAction[2].itemID)).itemName
            selItemLabel1.hidden = false
            selItemLabel2.hidden = false
            selItemLabel3.hidden = false
            break
        default:
            
            return false
        }
        
        // アイテム１が実行中の場合の文言を追加する.
        if (listActiveAction.count >= 1 && listActiveAction[0].actStartDate != nil) {
            selItemLabel1.text = selItemLabel1.text! + "\n（つぶし中...）"
        }
        
        // エラーフラグを返却する.
        return true
        
    }
    
    //****************************************
    // MARK: - DB Access
    //****************************************
    
    /** 未実行・実行中のアクティブなアイテムの取得 **/
    func getT_ActionResultWithActive() -> [T_ActionResult]  {
        print(NSDate().description, NSStringFromClass(self.classForCoder), __FUNCTION__, __LINE__)
        
        // 返却するアイテム
        var actionList :[T_ActionResult] = []
        
        // 取得済アイテムテーブルにアクセスし存在しなければfalseを返却する.
        let tempList :[T_ActionResult] = T_ActionResult.MR_findByAttribute("charaID", withValue: Const.CHARACTER1_ID, andOrderBy: "actSetDate,actStartDate,actEndDate", ascending: true) as! [T_ActionResult];

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
        print(NSDate().description, NSStringFromClass(self.classForCoder), __FUNCTION__, __LINE__)
        
        // 指定されたアイテムをテーブルに行動実績テーブルに追加.
        let insertData = T_ActionResult.MR_createEntity()! as T_ActionResult
        insertData.charaID = Const.CHARACTER1_ID
        insertData.itemID = itemId
        insertData.actSetDate = NSDate()
        insertData.managedObjectContext!.MR_saveToPersistentStoreAndWait()
        
        // 取得済アイテムマスタの所持数を減算する.
        let deleteItem = getT_GetItemForKey(itemId)
        
        // 現在のアイテム数が1個の場合
        if Int(deleteItem.itemCountValue) <= 1 {
            
            // 対象レコードを削除する.
            deleteItem.MR_deleteEntity()
            deleteItem.managedObjectContext!.MR_saveToPersistentStoreAndWait()

        } else {

            // 対象レコードのアイテム数を減らす.
            let updPredicate: NSPredicate = NSPredicate(format: "charaID = %@ AND itemID = %@", argumentArray:[String(Const.CHARACTER1_ID),String(itemId)]);
            
            let updateData = T_GetItem.MR_findFirstWithPredicate(updPredicate)! as T_GetItem
            
            // 所持アイテムを減算して更新する.
            updateData.itemCountValue -= 1
            updateData.managedObjectContext!.MR_saveToPersistentStoreAndWait()
        }
        
    }
    
    /** 未実行・実行中のアクティブなアイテムの削除 **/
    func deleteT_ActionResultWithActive(deleteData: T_ActionResult) {
        print(NSDate().description, NSStringFromClass(self.classForCoder), __FUNCTION__, __LINE__)
        
        // 削除対象のアイテム情報を取得しておく.
        let itemID: Int = Int(deleteData.itemID)
        let insertData = getT_GetItemForKey(itemID)
        
        // 指定されたアイテムを行動実績テーブルから削除.
        deleteData.MR_deleteEntity()
        deleteData.managedObjectContext!.MR_saveToPersistentStoreAndWait()
        
        // 現在のアイテム数が0個（データなし）の場合
        if (insertData.itemCountValue == 0) {
            
            // 対象レコードを挿入する.
            insertData.itemID = itemID
            insertData.itemCountValue += 1
            insertData.managedObjectContext!.MR_saveToPersistentStoreAndWait()
            
        } else {
            
            // 対象レコードのアイテム数を加算する.
            let updPredicate: NSPredicate = NSPredicate(format: "charaID = %@ AND itemID = %@", argumentArray:[String(Const.CHARACTER1_ID),String(insertData.itemID)]);
            let updateData = T_GetItem.MR_findFirstWithPredicate(updPredicate)! as T_GetItem
            updateData.itemCountValue += 1
            updateData.managedObjectContext!.MR_saveToPersistentStoreAndWait()
        }

    }
    
    /** T_GetItemからアイテムIDにひもづく取得済アイテム１件の取得 **/
    func getT_GetItemForKey(itemId: Int) -> T_GetItem  {
        print(NSDate().description, NSStringFromClass(self.classForCoder), __FUNCTION__, __LINE__)

        // 取得済アイテムテーブルを取得.
        let itemTList :[T_GetItem] = T_GetItem.MR_findByAttribute("charaID", withValue: Const.CHARACTER1_ID, andOrderBy: "itemID", ascending: true) as! [T_GetItem];
        
        for havingItem in itemTList {
            
            // 一致する場合、アイテム情報をセットする.
            if havingItem.itemID == itemId {
                    
                // アイテムをセット
                return havingItem
            }
                
        }
        
        // アイテムが取得できなかった場合の返却用アイテム
        let nothingItem = T_GetItem.MR_createEntity()! as T_GetItem
        nothingItem.charaID = Const.CHARACTER1_ID
        nothingItem.itemCountValue = 0

        //作成したアイテムリストを返却
        return nothingItem
    }
    
    /** M_ItemからアイテムIDにひもづく取得済アイテム１件の取得 **/
    func getM_ItemForKey(itemId: Int) -> M_Item  {
        print(NSDate().description, NSStringFromClass(self.classForCoder), __FUNCTION__, __LINE__)
        
        // アイテムマスタを取得.
        let itemMList :[M_Item] = M_Item.MR_findByAttribute("itemID", withValue: itemId) as! [M_Item];
        
        // アイテムを返却.
        return itemMList[0]

    }
    
    /** T_GetItemから取得済アイテムの取得 **/
    func getT_GetItem() -> [Dictionary<String, String>]  {
        print(NSDate().description, NSStringFromClass(self.classForCoder), __FUNCTION__, __LINE__)
        
        // 取得済アイテムテーブルを取得.
        let itemTList :[T_GetItem] = T_GetItem.MR_findByAttribute("charaID", withValue: Const.CHARACTER1_ID, andOrderBy: "itemID", ascending: true) as! [T_GetItem];
        
        //返却するアイテムリスト
        var itemList : [Dictionary<String, String>] = []
        
        // アイテムマスタを取得.
        let itemMList :[M_Item] = M_Item.MR_findAllSortedBy("itemID", ascending: true) as! [M_Item];
        
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