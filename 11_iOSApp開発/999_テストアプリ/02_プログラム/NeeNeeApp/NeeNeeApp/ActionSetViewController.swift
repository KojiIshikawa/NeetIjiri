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
    private var setItemCnt: Int8 = 0
    
    private let mySeSetPath = NSBundle.mainBundle().pathForResource("se1", ofType:"mp3")
    
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
        layout.itemSize = CGSizeMake(50, 50)
        
        // Cellのマージン.
        layout.sectionInset = UIEdgeInsetsMake(16, 16, 32, 16)
        
        // セクション毎のヘッダーサイズ.
        layout.headerReferenceSize = CGSizeMake(0,0)
    
        itemCollectionView = UICollectionView(frame: CGRectMake(0,0,0,0), collectionViewLayout: layout)
        itemCollectionView.registerClass(itemCell.self, forCellWithReuseIdentifier: "cell")
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        
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
        //super.touchesBegan(touches, withEvent: event)
        /**
        // タッチイベントを取得
        let touchEvent = touches.first!
        touchesPosition.x = touchEvent.locationInView(self.view).x
        touchesPosition.y = touchEvent.locationInView(self.view).y
        
        print(touchesPosition.x)
        print(touchesPosition.y)
        **/
        
    }
    
    
    // 画面ドラッグで呼ばれる
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        print(NSDate().description, __FUNCTION__, __LINE__)
        print("外で離した")

        
    }
    
    /**
    /** 暇つぶしアイテム長押し時の処理 **/
    func handleTap(recognizer: UITapGestureRecognizer) {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        print(recognizer.locationInView(self.view).x)
        print(recognizer.locationInView(self.view).y)
        
    }
**/
    
    /** 暇つぶしアイテム長押し時の処理 **/
    func cellLongTap(recognizer: UILongPressGestureRecognizer) {
        print(NSDate().description, __FUNCTION__, __LINE__)
        print("長押し")
        
        // 押された位置でcellのPathを取得
        let point = recognizer.locationInView(itemCollectionView)
        
        let indexPath = self.itemCollectionView.indexPathForItemAtPoint(point)
        
        /**
        // パスが取得できない場合は処理終了
        if indexPath == nil {
            return
        }
        **/

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
                selItemView.frame.size = CGSizeMake(50,50)
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
                
                // セット中アイテムをカウントアップ
                setItemCnt += 1
                
                // 領域内の場合、セットアイテムをセットする.
                setItemImageReLoad()
                /**
                let a : NeetMainViewController = NeetMainViewController()
                UIApplication.
                super.seSoundPlay(mySeSetPath!)
                **/                

                print("セットされたアイテムのアイテムコード：")
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
        return 26
    }
    
    /** セルが表示されるときに呼ばれる処理（1個のセルを描画する毎に呼び出されます） **/
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        print(NSDate().description, __FUNCTION__, __LINE__)
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! itemCell
        
        // セルの情報を設定する.
        cell._name.text = "×"+"1"
        cell._img.image = self.getUncachedImage( named: "06_01_01.png")
 //       cell.contentView.addGestureRecognizer(collectionView.panGestureRecognizer)
        
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
                constant: 60
            ),

            // 横幅
            NSLayoutConstraint(
                item: self.setItemView,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1.0 / 4.0,
                constant: 0
            ),
            
            // 縦幅
            NSLayoutConstraint(
                item: self.setItemView,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0 / 6.0,
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
                constant: 20
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
                toItem: self.view,
                attribute: .Height,
                multiplier: 1.0 / 1.5,
                constant: 0
            )]
        )
    }

    /** セット済みアイテムの円グラフを再描画する. **/
    func setItemImageReLoad ()
    {
        
        // 行動実績テーブルを読み込む
        // TODO トランザクションが読み込めるようになってから実装
        switch setItemCnt {
            
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
            
            // ダイアログを表示
            let alertController = UIAlertController(title: "忙しすぎて死んじゃう"
                , message: "未実行のひまをキャンセルしてください。", preferredStyle: .Alert)
            
            let defaultActionYes = UIAlertAction(title: "OK", style: .Default, handler:nil)
            
            alertController.addAction(defaultActionYes)
            
            presentViewController(alertController, animated: true, completion: nil)
            
        }
    }
}