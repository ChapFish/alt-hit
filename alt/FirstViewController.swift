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
let lectureStatus = ["経済学部", "", "社会学部", "法学部", "経済学部"]
let lectureFlag = [false, false, false, false, true]
let textCardTitles = ["title1","title2","title3","title4"]
let textCardContents = ["content1","content2","content3","content4"]

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var CardTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.CardTableView.register(UINib(nibName: "LectureCardTableViewCell", bundle:nil), forCellReuseIdentifier: "LectureCardViewCellID")
        self.CardTableView.register(UINib(nibName: "TextCardTableViewCell", bundle:nil), forCellReuseIdentifier: "TextCardTableViewCellID")

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
    
    //ここからTableViewに必要なプロトコル。
    func numberOfSections(in tableView:UITableView) -> Int{
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 1{
            return textCardTitles.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "LectureCardViewCellID", for: indexPath) as! LectureCardTableViewCell
            cell.setLectureCard(lectureName: lectureName, lectureRoom: lectureRoom, lectureStatus: lectureStatus, lectureFlag: lectureFlag)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextCardTableViewCellID", for: indexPath) as! TextCardTableViewCell
            cell.setTextCard(cardNumber: indexPath.row, title: textCardTitles, content: textCardContents)
            return cell
        }
    }
    
}
