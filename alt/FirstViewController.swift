//
//  FirstViewController.swift
//  alt
//
//  Created by 岡田航汰 on 2017/07/16.
//  Copyright © 2017年 Kota Okada. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //実験用定数
    let lectureName = ["経済学入門", "", "社会科学概論", "法学入門", "経済学入門"]
    let lectureRoom = ["1201", "", "21", "20", "401"]
    let lectureStatus = ["経済学部", "", "社会学部", "法学部", "経済学部"]
    let lectureFlag = [false, false, false, false, true]
    let textCardTitles = ["title1","title2","title3","title4"]
    let textCardContents = ["content1","content2","content3","content4"]
    var toDayWeatherData = ["loading","loading","loading","loading"]
    
    @IBOutlet weak var CardTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.CardTableView.register(UINib(nibName: "LectureCardTableViewCell", bundle:nil), forCellReuseIdentifier: "LectureCardViewCellID")
        self.CardTableView.register(UINib(nibName: "WeatherCardTableViewCell", bundle:nil), forCellReuseIdentifier:"WeatherCardTableViewCellID")
        self.CardTableView.register(UINib(nibName: "TextCardTableViewCell", bundle:nil), forCellReuseIdentifier: "TextCardTableViewCellID")

        //セルの高さを自動設定
        self.CardTableView.estimatedRowHeight = 200
        self.CardTableView.rowHeight = UITableViewAutomaticDimension
        
        //カードテーブルの背景色を指定
        self.CardTableView.backgroundColor = UIColor.colorFromRGB(rgb: "EBEBEB", alpha: 1.0)
        
        getTodayWeatherData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //ここからTableViewに必要なプロトコル。
    func numberOfSections(in tableView:UITableView) -> Int{
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return textCardContents.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LectureCardViewCellID", for: indexPath) as! LectureCardTableViewCell
            cell.setLectureCard(lectureName: lectureName, lectureRoom: lectureRoom, lectureStatus: lectureStatus, lectureFlag: lectureFlag)
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCardTableViewCellID", for: indexPath) as! WeatherCardTableViewCell
            cell.setWeatherCell(todayWeatherData: toDayWeatherData)
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextCardTableViewCellID", for: indexPath) as! TextCardTableViewCell
            cell.setTextCard(cardNumber: indexPath.row, title: textCardTitles, content: textCardContents)
            return cell
            
        default:
            //書かないわけには行かないから、とりあえずテキストカードのもので書いておく。
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextCardTableViewCellID", for: indexPath) as! TextCardTableViewCell
            cell.setTextCard(cardNumber: indexPath.row, title: textCardTitles, content: textCardContents)
            return cell
        }
    }
    
    //今日の天気を取得する関数。
    func getTodayWeatherData() {
        Alamofire.request("http://api.openweathermap.org/data/2.5/weather", parameters: ["q":"Kunitachi", "appid":"8754aa3f67b1bfd63319a928da5cc860"]).responseJSON{response in
            guard let object = response.result.value else{
                print("error")
                return
            }
            print("Now loading")
            let json = JSON(object)
            self.toDayWeatherData[0]=(json["main"]["temp_max"].stringValue)
            self.toDayWeatherData[1]=(json["main"]["temp_min"].stringValue)
            self.toDayWeatherData[2]=(json["weather"][0]["main"].stringValue)
            self.toDayWeatherData[3]=(json["main"]["humidity"].stringValue)
            print("loading compleated")
            self.CardTableView.reloadData()
        }
    }
    
}
