//
//  ActionSetViewController.swift
//  NeeNeeApp
//
//  Created by Boil Project on 2016/02/07.
//  Copyright © 2016年 Boil Project. All rights reserved.
//

import UIKit
import iAd
import AVFoundation

//暇つぶしをセットする画面です。
class ActionSetViewController: UIViewController, AVAudioPlayerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIGestureRecognizerDelegate,UIPopoverPresentationControllerDelegate  {
    
    // 暇つぶしメニューのオブジェクト
    fileprivate var itemCollectionView: UICollectionView!
    fileprivate var setItemView: UIImageView!
    fileprivate var selItemView: UIImageView!
    fileprivate var mainImgView: UIImageView!

    // セット中のアイテム情報ラベル
    fileprivate var selItemLabel1: UILabel!
    fileprivate var selItemLabel2: UILabel!
    fileprivate var selItemLabel3: UILabel!
    
    //コレクションビューにセットするアイテムリスト
    fileprivate var itemList: [Dictionary <String,String>] = []
    fileprivate var itemListIdxPath: Int = -1
    
    //取得済みセットアクションリスト
    fileprivate var listActiveAction:[T_ActionResult] = []
    
    // view アンロード開始時
    override func viewWillDisappear(_ animated: Bool) {
        
        // SEを再生する.
        Utility.seSoundPlay(Const.SE_NO_PATH)
    }
    
    override func viewDidLoad() {
        
        // ポップの背景を設定する.
        mainImgView = UIImageView(frame: self.view.frame)
        mainImgView.image = Utility.getUncachedImage(named: "02_01_01.png")

        // セット中アイテムラベルの生成.
        selItemLabel1 = UILabel()
        selItemLabel2 = UILabel()
        selItemLabel3 = UILabel()
        selItemLabel1.sizeToFit()
        selItemLabel2.sizeToFit()
        selItemLabel3.sizeToFit()
        selItemLabel1.numberOfLines = 0
        selItemLabel2.numberOfLines = 0
        selItemLabel3.numberOfLines = 0
        
        // セット済みアイテムの初期設定.
        setItemView = UIImageView()
        
        // 長押しイベント登録.
        selItemLabel1.tag = 11
        selItemLabel2.tag = 12
        selItemLabel3.tag = 13
        
        // 文字サイズ指定.
        selItemLabel1.font = UIFont.systemFont(ofSize: Utility.getMojiSize(Const.SIZEKBN_LARGE))
        selItemLabel2.font = UIFont.systemFont(ofSize: Utility.getMojiSize(Const.SIZEKBN_LARGE))
        selItemLabel3.font = UIFont.systemFont(ofSize: Utility.getMojiSize(Const.SIZEKBN_LARGE))
        
        selItemLabel1.isUserInteractionEnabled = true
        selItemLabel2.isUserInteractionEnabled = true
        selItemLabel3.isUserInteractionEnabled = true
        
        let setItem1LongTouchRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(ActionSetViewController.setItemLongTouch(_:)))
        setItem1LongTouchRecognizer.minimumPressDuration = 0.2
        setItem1LongTouchRecognizer.delegate = self
        selItemLabel1.addGestureRecognizer(setItem1LongTouchRecognizer)
        
        let setItem2LongTouchRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(ActionSetViewController.setItemLongTouch(_:)))
        setItem2LongTouchRecognizer.minimumPressDuration = 0.2
        setItem2LongTouchRecognizer.delegate = self
        selItemLabel2.addGestureRecognizer(setItem2LongTouchRecognizer)
        
        let setItem3LongTouchRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(ActionSetViewController.setItemLongTouch(_:)))
        setItem3LongTouchRecognizer.minimumPressDuration = 0.2
        setItem3LongTouchRecognizer.delegate = self
        selItemLabel3.addGestureRecognizer(setItem3LongTouchRecognizer)
        
        // CollectionViewのレイアウトを生成.
        let layout = UICollectionViewFlowLayout()

        // Cell一つ一つの大きさを設定.
        layout.itemSize = CGSize(
            width: CGFloat(self.view.frame.height / 6.8)
            , height: CGFloat(self.view.frame.height / 6.8))
        
        //NSUserDefaultにアクションセット画面のサイズを保存
        let ud1 = UserDefaults.standard
        ud1.set(Float(CGFloat(self.view.frame.height / 6.8)), forKey: "ACTIONSET_SIZE")
        ud1.synchronize()
        
        // 横スクロール
        layout.scrollDirection = .horizontal
        itemCollectionView = UICollectionView(frame: CGRect(x: 0,y: 0,width: 0,height: 0), collectionViewLayout: layout)
        itemCollectionView.register(itemCell.self, forCellWithReuseIdentifier: "cell")
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        
        // セットアイテムの再描画.
        _ = setItemImageReLoad()
        
        // セル長押しイベント登録
        // 長押し用レコグナイザー
        let cellitemCellLongTouchRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(ActionSetViewController.itemCellLongTouch(_:)))
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        
    }
    
    
    // 画面ドラッグで呼ばれる
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        
    }

    /** 暇つぶしアイテム長押し時の処理 **/
    func setItemLongTouch(_ recognizer: UILongPressGestureRecognizer) {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)

        switch recognizer.state {
            
            //長押し-タッチ時の処理
        case UIGestureRecognizerState.began:
            
            //バイブを鳴らす
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            // SEを再生する.
            Utility.seSoundPlay(Const.SE_ITEMSEL_PATH)
            
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
                let myImage = Utility.getUncachedImage( named: String(validatingUTF8: getM_ItemForKey(Int(picItemID)).imageItem)!)!
                
                
                // 選択中表示用アイテムが未作成なら作成する.
                if selItemView == nil {
                    
                    // セッションからアクションセット画面のサイズを取得
                    let ud1 = UserDefaults.standard
                    let udActionSize : CGFloat! = CGFloat(ud1.float(forKey: "ACTIONSET_SIZE")) * 1.5
                    
                    selItemView = UIImageView()
                    selItemView.image = myImage
                    selItemView.alpha = 0.8
                    selItemView.frame.size = CGSize(width: udActionSize,height: udActionSize)
                    selItemView.frame.origin.x = (recognizer.view?.frame.origin.x)! + (selItemView.frame.size.width / 2)
                    selItemView.frame.origin.y = (recognizer.view?.frame.origin.y)! + (selItemView.frame.size.height / 2)
                    self.view.addSubview(selItemView)
                }
            }
            
            //長押し-指を離した時の処理
        case UIGestureRecognizerState.ended:
            
            // セットアイテムの領域内の場合
            if recognizer.location(in: self.view).x <= itemCollectionView.frame.maxX
                && recognizer.location(in: self.view).x >= itemCollectionView.frame.origin.x
                && recognizer.location(in: self.view).y <= itemCollectionView.frame.maxY
                && recognizer.location(in: self.view).y >= itemCollectionView.frame.origin.y {
                    
                    switch Int((recognizer.view?.tag)!) {
                    case 11:
                        
                        // セットアイテム１の場合
                        if cancelItemActiveChk().boolValue {

                            // セットアイテム１をアクションテーブルから削除する.
                            deleteT_ActionResultWithActive(listActiveAction[0])
                            
                            // SEを再生する.
                            Utility.seSoundPlay(Const.SE_ITEMCANCEL_PATH)
                            
                        } else {

                            // SEを再生する.
                            Utility.seSoundPlay(Const.SE_ITEMSET_NG_PATH)

                        }
                        
                    case 12:
                        
                        // セットアイテム２の場合
                        // セットアイテム２をアクションテーブルから削除する.
                        deleteT_ActionResultWithActive(listActiveAction[1])

                        // SEを再生する.
                        Utility.seSoundPlay(Const.SE_ITEMCANCEL_PATH)
                        
                    default:
                        
                        // セットアイテム３の場合
                        // セットアイテム３をアクションテーブルから削除する.
                        deleteT_ActionResultWithActive(listActiveAction[2])
                        
                        // SEを再生する.
                        Utility.seSoundPlay(Const.SE_ITEMCANCEL_PATH)
                        break
                        
                    }
                    
            }
            
            // 選択中アイテムのイメージを破棄する.
            selItemView.removeFromSuperview()
            selItemView = nil
            
            // セットアイテムの再描画.
            _ = setItemImageReLoad()
            
        default: break
            
        }
        
        // 画像がある場合は画像位置を移動
        if selItemView != nil {
            
            // 選択したアイテムの画像位置をタップ中の位置に常に合わせる.
            selItemView.frame.origin.x = recognizer.location(in: self.view).x - (selItemView.frame.size.width / 2)
            selItemView.frame.origin.y = recognizer.location(in: self.view).y - (selItemView.frame.size.height / 2)
        }

        
    }
    
    /** 暇つぶしアイテム長押し時の処理 **/
    func itemCellLongTouch(_ recognizer: UILongPressGestureRecognizer) {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        
        switch recognizer.state {
            
          //長押し-タッチ時の処理
          case UIGestureRecognizerState.began:
            
            // 押された位置でcellのPathを取得する.
            let point = recognizer.location(in: itemCollectionView)
            
            // 選択されたアイテムをメンバ変数に保持しておく.
            itemListIdxPath = self.itemCollectionView.indexPathForItem(at: point) == nil
                ? -1 : ((self.itemCollectionView.indexPathForItem(at: point) as NSIndexPath?)?.row)!
            
            // 長押しされた場合の処理
            // アイテムが選択されている場合のみ処理する.
            if itemListIdxPath > -1 {
                
                //バイブを鳴らす
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                
                // SEを再生する.
                Utility.seSoundPlay(Const.SE_ITEMSEL_PATH)
            
                // タップされたアイテムの画像を半透明で表示する
                let myImage = Utility.getUncachedImage( named: String(validatingUTF8: itemList[itemListIdxPath]["imageItem"]!)!)
            
                // 選択中表示用アイテムが未作成なら作成する.
                if selItemView == nil {
                
                    // セッションからアクションセット画面のサイズを取得
                    let ud1 = UserDefaults.standard
                    let udActionSize : CGFloat! = CGFloat(ud1.float(forKey: "ACTIONSET_SIZE")) * 1.5
                    
                    selItemView = UIImageView()
                    selItemView.image = myImage
                    selItemView.alpha = 0.8
                    selItemView.frame.size = CGSize(width: udActionSize,height: udActionSize)
                    self.view.addSubview(selItemView)
                }
                
            }
            
          //長押し-指を離した時の処理
          case UIGestureRecognizerState.ended:
            
            // セットアイテムの領域内の場合
            if recognizer.location(in: self.view).x <= setItemView.frame.maxX
                && recognizer.location(in: self.view).x >= setItemView.frame.origin.x
                && recognizer.location(in: self.view).y <= setItemView.frame.maxY
                && recognizer.location(in: self.view).y >= setItemView.frame.origin.y {
                    
                    // アイテムが選択されている場合のみ処理する.
                    if itemListIdxPath > -1 {
                        
                        // セットアイテムの再描画.
                        if setItemOverChk().boolValue {
                            
                            // SEを再生する.
                            Utility.seSoundPlay(Const.SE_ITEMSET_PATH)

                            // セットアイテムをデータベースに書き込む.
                            insertT_ActionResultWithActive(Int(itemList[itemListIdxPath]["itemID"]!)!)
                            
                            // 画面を再描画する.
                            _ = setItemImageReLoad()
                            
                        } else {
                            
                            // SEを再生する.
                            Utility.seSoundPlay(Const.SE_ITEMSET_NG_PATH)
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
            selItemView.frame.origin.x = recognizer.location(in: self.view).x - (selItemView.frame.size.width / 2)
            selItemView.frame.origin.y = recognizer.location(in: self.view).y - (selItemView.frame.size.height / 2)
            
        }
    }
    
    //****************************************
    // MARK: - Collection View Delegate
    //****************************************
    
    // Cellが選択された際に呼び出される
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        
    }
    
    /** セクションの数 **/
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        return 1
    }
    
    /** 表示するセルの数 **/
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        return itemList.count
    }
    
    /** セルが表示されるときに呼ばれる処理（1個のセルを描画する毎に呼び出されます） **/
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(Date().description, NSStringFromClass(self.classForCoder), #function, #line)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! itemCell
        cell._name.sizeToFit()
        
        // セルの情報を設定する.
        cell._name.text = itemList[(indexPath as NSIndexPath).row]["itemName"]! + "\n×" + itemList[(indexPath as NSIndexPath).row]["itemCountValue"]!
        cell._img.image = Utility.getUncachedImage( named: itemList[(indexPath as NSIndexPath).row]["imageItem"]!)
        
        // セルを返却する.
        return cell
    }

    //****************************************
    // MARK: - その他メソッド
    //****************************************
    
    /** 全オブジェクトの制約設定 **/
    func objConstraints() {
        print(Date().description, NSStringFromClass(self.classForCoder), #function,#line)
   
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
                attribute:  NSLayoutAttribute.right,
                relatedBy: .equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.right,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.mainImgView,
                attribute: NSLayoutAttribute.bottom,
                relatedBy: .equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.bottom,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.mainImgView,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .width,
                multiplier: 1.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.mainImgView,
                attribute: .height,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .height,
                multiplier: 1.0,
                constant: 0
            )]
        )
        
        // セットアイテムメニューの制約
        self.view.addConstraints([

            // x座標
            NSLayoutConstraint(
                item: self.setItemView,
                attribute:  NSLayoutAttribute.centerX,
                relatedBy: .equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.centerX,
                multiplier: 1.0,
                constant: 0
            ),

            // y座標
            NSLayoutConstraint(
                item: self.setItemView,
                attribute: NSLayoutAttribute.top,
                relatedBy: .equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.bottom,
                multiplier: 1.0 / 8.0,
                constant: 0
            ),

            // 横幅
            NSLayoutConstraint(
                item: self.setItemView,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .width,
                multiplier: 1.0 / 1.8,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.setItemView,
                attribute: .height,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .height,
                multiplier: 1.0 / 2.6,
                constant: 0
            )]
        )
        
        // セットアイテムラベル３の制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.selItemLabel3,
                attribute:  NSLayoutAttribute.left,
                relatedBy: .equal,
                toItem: self.setItemView,
                attribute:  NSLayoutAttribute.left,
                multiplier: 1.0 / 1.6,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.selItemLabel3,
                attribute: NSLayoutAttribute.top,
                relatedBy: .equal,
                toItem: self.setItemView,
                attribute:  NSLayoutAttribute.top,
                multiplier: 1.5 / 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.selItemLabel3,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .width,
                multiplier: 0.35 / 1.0,
                constant: 0
            )]
        )

        // セットアイテムラベル２の制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.selItemLabel2,
                attribute:  NSLayoutAttribute.centerX,
                relatedBy: .equal,
                toItem: self.setItemView,
                attribute:  NSLayoutAttribute.centerX,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.selItemLabel2,
                attribute: NSLayoutAttribute.top,
                relatedBy: .equal,
                toItem: self.setItemView,
                attribute:  NSLayoutAttribute.bottom,
                multiplier: 0.94 / 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.selItemLabel2,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .width,
                multiplier: 0.35 / 1.0,
                constant: 0
            )]
        )

        // セットアイテムラベル１の制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.selItemLabel1,
                attribute:  NSLayoutAttribute.right,
                relatedBy: .equal,
                toItem: self.setItemView,
                attribute:  NSLayoutAttribute.right,
                multiplier: 1.2 / 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.selItemLabel1,
                attribute: NSLayoutAttribute.top,
                relatedBy: .equal,
                toItem: self.setItemView,
                attribute:  NSLayoutAttribute.top,
                multiplier: 1.5 / 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.selItemLabel1,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .width,
                multiplier: 0.35 / 1.0,
                constant: 0
            )]
        )
        
        // コレクションビューの制約
        self.view.addConstraints([
            
            // x座標
            NSLayoutConstraint(
                item: self.itemCollectionView,
                attribute:  NSLayoutAttribute.centerX,
                relatedBy: .equal,
                toItem: self.view,
                attribute:  NSLayoutAttribute.centerX,
                multiplier: 1.0,
                constant: 0
            ),
            
            // y座標
            NSLayoutConstraint(
                item: self.itemCollectionView,
                attribute: NSLayoutAttribute.top,
                relatedBy: .equal,
                toItem: self.setItemView,
                attribute:  NSLayoutAttribute.bottom,
                multiplier: 1.2 / 1.0,
                constant: 0
            ),
            
            // 横幅
            NSLayoutConstraint(
                item: self.itemCollectionView,
                attribute: .width,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .width,
                multiplier: 1.0 / 1.2,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.itemCollectionView,
                attribute: .height,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .height,
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
                , message: "未実行のひまをキャンセルしてください。", preferredStyle: .alert)
            let defaultActionYes = UIAlertAction(title: "OK", style: .default, handler:nil)
            alertController.addAction(defaultActionYes)
            present(alertController, animated: true, completion: nil)
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
                    , message: "ひまつぶし中のひまはキャンセルできません。", preferredStyle: .alert)
                let defaultActionYes = UIAlertAction(title: "OK", style: .default, handler:nil)
                alertController.addAction(defaultActionYes)
                present(alertController, animated: true, completion: nil)
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
            selItemLabel1.isHidden = true
            selItemLabel2.isHidden = true
            selItemLabel3.isHidden = true
            break
        case 1:
            setItemView.image = Utility.getUncachedImage( named: "02_05_02.png")
            selItemLabel1.text = getM_ItemForKey(Int(listActiveAction[0].itemID)).itemName
            selItemLabel2.text = ""
            selItemLabel3.text = ""
            selItemLabel1.isHidden = false
            selItemLabel2.isHidden = true
            selItemLabel3.isHidden = true
            break
        case 2:
            setItemView.image = Utility.getUncachedImage( named: "02_05_03.png")
            selItemLabel1.text = getM_ItemForKey(Int(listActiveAction[0].itemID)).itemName
            selItemLabel2.text = getM_ItemForKey(Int(listActiveAction[1].itemID)).itemName
            selItemLabel3.text = ""
            selItemLabel1.isHidden = false
            selItemLabel2.isHidden = false
            selItemLabel3.isHidden = true
            break
        case 3:
            setItemView.image = Utility.getUncachedImage( named: "02_05_04.png")
            selItemLabel1.text = getM_ItemForKey(Int(listActiveAction[0].itemID)).itemName
            selItemLabel2.text = getM_ItemForKey(Int(listActiveAction[1].itemID)).itemName
            selItemLabel3.text = getM_ItemForKey(Int(listActiveAction[2].itemID)).itemName
            selItemLabel1.isHidden = false
            selItemLabel2.isHidden = false
            selItemLabel3.isHidden = false
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
        print(Date().description, NSStringFromClass(self.classForCoder), #function,#line)
        
        // 返却するアイテム
        var actionList :[T_ActionResult] = []
        
        // 取得済アイテムテーブルにアクセスし存在しなければfalseを返却する.
        let tempList :[T_ActionResult] = T_ActionResult.mr_find(byAttribute: "charaID", withValue: Const.CHARACTER1_ID, andOrderBy: "actSetDate,actStartDate,actEndDate", ascending: true) as! [T_ActionResult];

        print(actionList.count)
        
        for temp in tempList {
            
            // 実行中または未実行のデータをセットする.
            if temp.actEndDate == nil {
                
                actionList.insert(temp, at: actionList.count)
            } else {
                continue
            }
        }
        
        return  actionList
    }

    /** 未実行・実行中のアクティブなアイテムの追加 **/
    func insertT_ActionResultWithActive(_ itemId: Int) {
        print(Date().description, NSStringFromClass(self.classForCoder), #function,#line)
        
        // 指定されたアイテムをテーブルに行動実績テーブルに追加.
        let insertData = T_ActionResult.mr_createEntity()! as T_ActionResult
        insertData.charaID = Const.CHARACTER1_ID as NSNumber!
        insertData.itemID = itemId as NSNumber!
        insertData.actSetDate = Date()
        insertData.finishFlg = 0
        insertData.managedObjectContext!.mr_saveToPersistentStoreAndWait()
        
        // 取得済アイテムマスタの所持数を減算する.
        let deleteItem = getT_GetItemForKey(itemId)
        
        // 現在のアイテム数が1個の場合
        if Int(deleteItem.itemCountValue) <= 1 {
            
            // 対象レコードを削除する.
            deleteItem.mr_deleteEntity()
            deleteItem.managedObjectContext!.mr_saveToPersistentStoreAndWait()

        } else {

            // 対象レコードのアイテム数を減らす.
            let updPredicate: NSPredicate = NSPredicate(format: "charaID = %@ AND itemID = %@", argumentArray:[String(Const.CHARACTER1_ID),String(itemId)]);
            
            let updateData = T_GetItem.mr_findFirst(with: updPredicate)! as T_GetItem
            
            // 所持アイテムを減算して更新する.
            updateData.itemCountValue -= 1
            updateData.managedObjectContext!.mr_saveToPersistentStoreAndWait()
        }
        
    }
    
    /** 未実行・実行中のアクティブなアイテムの削除 **/
    func deleteT_ActionResultWithActive(_ deleteData: T_ActionResult) {
        print(Date().description, NSStringFromClass(self.classForCoder), #function,#line)
        
        // 削除対象のアイテム情報を取得しておく.
        let itemID: Int = Int(deleteData.itemID)
        let insertData = getT_GetItemForKey(itemID)
        
        // 指定されたアイテムを行動実績テーブルから削除.
        deleteData.mr_deleteEntity()
        deleteData.managedObjectContext!.mr_saveToPersistentStoreAndWait()
        
        // 現在のアイテム数が0個（データなし）の場合
        if (insertData.itemCountValue == 0) {
            
            // 対象レコードを挿入する.
            insertData.itemID = itemID as NSNumber!
            insertData.itemCountValue += 1
            insertData.managedObjectContext!.mr_saveToPersistentStoreAndWait()
            
        } else {
            
            // 対象レコードのアイテム数を加算する.
            let updPredicate: NSPredicate = NSPredicate(format: "charaID = %@ AND itemID = %@", argumentArray:[String(Const.CHARACTER1_ID),String(describing: insertData.itemID)]);
            let updateData = T_GetItem.mr_findFirst(with: updPredicate)! as T_GetItem
            updateData.itemCountValue += 1
            updateData.managedObjectContext!.mr_saveToPersistentStoreAndWait()
        }

    }
    
    /** T_GetItemからアイテムIDにひもづく取得済アイテム１件の取得 **/
    func getT_GetItemForKey(_ itemId: Int) -> T_GetItem  {
        print(Date().description, NSStringFromClass(self.classForCoder), #function,#line)

        // 取得済アイテムテーブルを取得.
        let itemTList :[T_GetItem] = T_GetItem.mr_find(byAttribute: "charaID", withValue: Const.CHARACTER1_ID, andOrderBy: "itemID", ascending: true) as! [T_GetItem];
        
        for havingItem in itemTList {
            
            // 一致する場合、アイテム情報をセットする.
            if Int(havingItem.itemID) == Int(itemId) {
                    
                // アイテムをセット
                return havingItem
            }
                
        }
        
        // アイテムが取得できなかった場合の返却用アイテム
        let nothingItem = T_GetItem.mr_createEntity()! as T_GetItem
        nothingItem.charaID = Const.CHARACTER1_ID as NSNumber!
        nothingItem.itemCountValue = 0

        //作成したアイテムリストを返却
        return nothingItem
    }
    
    /** M_ItemからアイテムIDにひもづく取得済アイテム１件の取得 **/
    func getM_ItemForKey(_ itemId: Int) -> M_Item  {
        print(Date().description, NSStringFromClass(self.classForCoder), #function,#line)
        
        // アイテムマスタを取得.
        let itemMList :[M_Item] = M_Item.mr_find(byAttribute: "itemID", withValue: itemId) as! [M_Item];
        
        // アイテムを返却.
        return itemMList[0]

    }
    
    /** T_GetItemから取得済アイテムの取得 **/
    func getT_GetItem() -> [Dictionary<String, String>]  {
        print(Date().description, NSStringFromClass(self.classForCoder), #function,#line)
        
        // 取得済アイテムテーブルを取得.
        let itemTList :[T_GetItem] = T_GetItem.mr_find(byAttribute: "charaID", withValue: Const.CHARACTER1_ID, andOrderBy: "itemID", ascending: true) as! [T_GetItem];
        
        //返却するアイテムリスト
        var itemList : [Dictionary<String, String>] = []
        
        // アイテムマスタを取得.
        let itemMList :[M_Item] = M_Item.mr_findAllSorted(by: "itemID", ascending: true) as! [M_Item];
        
        for havingItem in itemTList {

            for masterItem in itemMList {
                
                // 一致する場合、アイテム情報セットする.
                if havingItem.itemID == masterItem.itemID {

                    // アイテムをセット
                    var itemDic : Dictionary<String, String> = Dictionary<String, String>()
                    itemDic["itemID"] = String(describing: havingItem.itemID)
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
