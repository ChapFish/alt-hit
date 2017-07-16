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

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var CardTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.CardTableView.register(UINib(nibName: "LectureCardTableViewCell", bundle:nil), forCellReuseIdentifier: "LectureCardViewCellID")

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

    func numberOfSections(in tableView:UITableView) -> Int{
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LectureCardViewCellID", for: indexPath) as! LectureCardTableViewCell
        cell.setLectureCard(lectureName: lectureName, lectureRoom: lectureRoom, lectureStatus: lectureStatus, lectureFlag: lectureFlag)
        return cell
    }
    
}
