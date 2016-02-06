//
//  ActionSetViewController.swift
//  NeeNeeApp
//
//  Created by v2_system on 2016/02/07.
//  Copyright © 2016年 KojiIshikawa. All rights reserved.
//

import Foundation



//暇つぶしをセットする画面です。
class ActionSetViewController: UIViewController {
    
    

    override func viewDidLoad() {
        
        
        
        //TODO:以下、動作確認用のコードです。不要。
        let myFukidasiImageView: UIImageView!
        let fukidasiImage = UIImage( named: "05_01_01")!
        myFukidasiImageView = UIImageView(frame: CGRectMake(0,0,200,100))
        myFukidasiImageView.frame.origin.x = 0.0
        myFukidasiImageView.frame.origin.y = 0.0
        myFukidasiImageView.image = fukidasiImage
        self.view.addSubview(myFukidasiImageView)

        
        

    }
    
    override func didReceiveMemoryWarning() {
    }

    
    
    
}