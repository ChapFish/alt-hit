//
//  FirstViewController.swift
//  alt
//
//  Created by 岡田航汰 on 2017/07/16.
//  Copyright © 2017年 Kota Okada. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire
import SwiftyJSON


class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let realm = try! Realm()
    var todayLectures: Results<RealmLecture>!
    
    var lectureName:[String] = []
    var lectureRoom:[String] = []
    var lectureDepartment:[Int] = []
    var lectureFlag:[Bool] = []
    var toDayWeatherData = ["loading","loading","loading","loading"]
    
    //var lectureName:[String] = []
    var postTitles:[String] = []
    var postContents:[String] = []
    
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
        
        getPostData()
        getTodayWeatherData()
        getTodayLecture()
    }

    override func viewDidAppear(_ animated: Bool) {
        performSegue(withIdentifier: "toStartTour", sender: nil)
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
            return postTitles.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LectureCardViewCellID", for: indexPath) as! LectureCardTableViewCell
            cell.setLectureCard(lectureName: lectureName, lectureRoom: lectureRoom, lectureStatus: lectureDepartment, lectureFlag: lectureFlag)
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCardTableViewCellID", for: indexPath) as! WeatherCardTableViewCell
            cell.setWeatherCell(todayWeatherData: toDayWeatherData)
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextCardTableViewCellID", for: indexPath) as! TextCardTableViewCell
            cell.setTextCard(cardNumber: indexPath.row, title: postTitles, content: postContents)
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LectureCardViewCellID", for: indexPath) as! LectureCardTableViewCell
            cell.setLectureCard(lectureName: lectureName, lectureRoom: lectureRoom, lectureStatus: lectureDepartment, lectureFlag: lectureFlag)
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        CardTableView.deselectRow(at: indexPath, animated: true)
    }
    
    //今日の天気を取得する関数。
    func getTodayWeatherData() {
        Alamofire.request("https://server.project-alt.tech/api/home/weather", parameters: ["limit":1]).responseJSON{response in
            guard let object = response.result.value else{
                print("error")
                return
            }
            let json = JSON(object)
            self.toDayWeatherData[0] = json[0]["max"].stringValue
            self.toDayWeatherData[1] = json[0]["min"].stringValue
            self.toDayWeatherData[2] = json[0]["weather"].stringValue
            self.toDayWeatherData[3] = json[0]["humidity"].stringValue
            self.CardTableView.reloadData()
        }
    }
    func getPostData(){
        Alamofire.request("https://server.project-alt.tech/api/home/posts").responseJSON{response in
            guard let object = response.result.value else{
                print("error")
                return
            }
            let json = JSON(object)
            json.forEach{(_, json) in
                self.postTitles.append(json["title"].stringValue)
                self.postContents.append(json["text"].stringValue)
            }
            self.CardTableView.reloadData()
        }
    }
    func getTodayLecture(){
        todayLectures = realm.objects(RealmLecture.self).filter("week = 0").sorted(byKeyPath: "time")
            lectureName.removeAll()
            lectureRoom.removeAll()
            lectureDepartment.removeAll()
            lectureFlag.removeAll()
        for i in 0...4{
            lectureName.append(todayLectures[i].name)
            lectureRoom.append(todayLectures[i].room)
            lectureDepartment.append(todayLectures[i].department)
            lectureFlag.append(todayLectures[i].cancelFlag)
        }
    }
   
}
