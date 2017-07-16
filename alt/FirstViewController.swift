//
//  FirstViewController.swift
//  alt
//
//  Created by 岡田航汰 on 2017/07/16.
//  Copyright © 2017年 Kota Okada. All rights reserved.
//

import UIKit

//実験用定数
let lectureName = ["経済学入門", "", "社会科学概論", "法学入門", "経済学入門"]
let lectureRoom = ["1201", "", "21", "20", "401"]

class FirstViewController: UIViewController {

    @IBOutlet weak var CardTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.CardTableView.register(UINib(nibName:"LectureCardViewCell", bundle:nil), forCellReuseIdentifier: "LectureCardViewCellID")

        //セルの高さを自動設定
        self.CardTableView.estimatedRowHeight = 200
        self.CardTableView.rowHeight = UITableViewAutomaticDimension
        
        //カードテーブルの背景色を指定
        self.CardTableView.backgroundColor = UIColor.colorFromRGB(rgb: "EBEBEB", alpha: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
