//
//  ProfileViewController.swift
//  NeeNeeApp
//
//  Created by v2_system on 2016/02/11.
//  Copyright © 2016年 KojiIshikawa. All rights reserved.
//

import Foundation



//履歴書画面です。
class ProfileViewController: UIViewController {

    // 履歴書メニューのオブジェクト
    private var nameDataLabel: UILabel!
    private var birthDataLabel: UILabel!
    private var positionDataLabel: UILabel!
    private var compDataLabel: UILabel!
    private var kakugenDataLabel: UILabel!

    private var detailImgView: UIImageView!
    private var detailImgSubView: UIImageView!
    
    private let detailViewImage = UIImage(named: "02_02_01.png")
    private let detailViewSubImage = UIImage(named: "02_06_01.png")
//    private var detailConView: UIView!
   

    
    // view ロード完了時
    override func viewDidLoad() {
        print(NSDate().description, __FUNCTION__, __LINE__)
        super.viewDidLoad()

        //背景設定
        detailImgView = UIImageView(frame: self.view.frame)
        detailImgView.image = detailViewImage
        self.view.addSubview(detailImgView)
        
        
        //TODO:将来的に不要になるであろう画像
        detailImgSubView = UIImageView(frame: CGRectMake(20,50,detailImgView.frame.width-60,detailImgView.frame.height-60))
        detailImgSubView.image = detailViewSubImage
        self.view.addSubview(detailImgSubView)
        
        
        //プロフィール設定
        self.nameDataLabel = UILabel(frame: CGRectMake(self.detailImgSubView.center.x,40,200,20))
        self.nameDataLabel.textAlignment = .Left
        self.nameDataLabel.text = "こうじ"
        self.birthDataLabel = UILabel(frame: CGRectMake(self.detailImgSubView.center.x,70,200,20))
        self.birthDataLabel.textAlignment = .Left
        self.birthDataLabel.text = "1990年3月31日"
        self.positionDataLabel = UILabel(frame: CGRectMake(self.detailImgSubView.center.x,100,200,20))
        self.positionDataLabel.textAlignment = .Left
        self.positionDataLabel.text = "ひきニート"
        self.compDataLabel = UILabel(frame: CGRectMake(self.detailImgSubView.center.x,130,200,30))
        self.compDataLabel.textAlignment = .Left
        self.compDataLabel.text = "部屋、台所、トイレ"
        self.kakugenDataLabel = UILabel(frame: CGRectMake(self.detailImgSubView.center.x,160,200,20))
        self.kakugenDataLabel.textAlignment = .Left
        self.kakugenDataLabel.text = "やる気！元気！いわき！"

        
        // ポップ上に表示するオブジェクトをViewに追加する.
//        detailImgView.addSubview(detailImgView)
//        detailImgView.addSubview(detailImgSubView)
        detailImgSubView.addSubview(nameDataLabel)
        detailImgSubView.addSubview(birthDataLabel)
        detailImgSubView.addSubview(positionDataLabel)
        detailImgSubView.addSubview(compDataLabel)
        detailImgSubView.addSubview(kakugenDataLabel)

        

        
        //        detailImgView.frame.size = self.view.frame.size

        
        //ポップ生成
//        detailConView = UIView(frame: CGRectMake(18,100,340,400))
//        detailImgView = UIImageView()
//        detailImgView.frame.size = detailConView.frame.size
//        detailImgSubView = UIImageView(frame: CGRectMake(20,50,detailConView.frame.width-60,detailConView.frame.height-60))
        
//        // ポップの背景を設定する.
//        detailImgView.image = detailViewImage
//        detailImgView.alpha = 0.9
//        detailImgSubView.image = detailViewSubImage
//        detailImgSubView.alpha = 0.9
//        
//        // 初期表示は非表示
//        detailConView.hidden = true
//        
//        
//        self.nameDataLabel = UILabel(frame: CGRectMake(130,10,200,20))
//        self.nameDataLabel.text = "こうじ"
//        self.birthDataLabel = UILabel(frame: CGRectMake(130,30,200,20))
//        self.birthDataLabel.text = "1990年3月31日"
//        self.positionDataLabel = UILabel(frame: CGRectMake(130,50,200,20))
//        self.positionDataLabel.text = "ひきニート"
//        self.compDataLabel = UILabel(frame: CGRectMake(130,70,200,30))
//        self.compDataLabel.text = "部屋、台所、トイレ"
//        self.kakugenDataLabel = UILabel(frame: CGRectMake(130,100,200,20))
//        self.kakugenDataLabel.text = "やる気！元気！いわき！"
//        
//        // ポップ上に表示するオブジェクトをViewに追加する.
//        detailConView.addSubview(detailImgView)
//        detailConView.addSubview(detailImgSubView)
//        detailConView.addSubview(nameDataLabel)
//        detailConView.addSubview(birthDataLabel)
//        detailConView.addSubview(positionDataLabel)
//        detailConView.addSubview(compDataLabel)
//        detailConView.addSubview(kakugenDataLabel)
//        
//        // ViewをViewに追加する.
//        self.view.addSubview(detailConView)
    }
    
    //メモリ消費が多くなった時に動くイベント
    override func didReceiveMemoryWarning() {
        print(NSDate().description, __FUNCTION__, __LINE__)
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
