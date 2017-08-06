//
//  LectureSelectingViewController.swift
//  alt
//
//  Created by 岡田航汰 on 2017/08/03.
//  Copyright © 2017年 Kota Okada. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LectureSelectingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    //検索結果を入れる
    var searchResult:[String] = []
    //パラメータ用の引数をLectureSettingViewControllerからもらい、設定中の授業を特定。
    var period:Int = 0
    var weekday:Int = 0
    //fetchしてきたデータを入れる。
    var ids:[String] = []
    var names:[String] = []
    var teachers:[String] = []
    var weeks:[String] = []
    var times:[String] = []
    var rooms:[String] = []
    var departments:[String] = []
    var seasons:[String] = []
    var cancelFlags:[String] = []
    
    //選択されたデータをまとめ、LectureSettingViewControllerに返す。
    var senderLectureData:[String] = []
    
    
    @IBAction func selectCancelButton(_ sender: Any) {
        performSegue(withIdentifier: "goBack", sender: nil)
    }
    @IBOutlet weak var lectureSeachBar: UISearchBar!
    @IBOutlet weak var lectureSelectingTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //サーチバーの初期設定
        lectureSeachBar.delegate = self
        lectureSeachBar.enablesReturnKeyAutomatically = false        //searchResult = Samplenames
        self.lectureSeachBar.layer.borderColor = UIColor.white.cgColor
        self.lectureSeachBar.layer.borderWidth = 1.0
        
        getLecturesData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "APeriodLecturesCellID", for: indexPath) as UITableViewCell
        cell.textLabel?.text = searchResult[indexPath.row]
        return cell
    }
    //セルをタップした時の動作
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index:Int = names.index(of: "\(searchResult[indexPath.row])")!
        senderLectureData.append(contentsOf: [ids[index],names[index],teachers[index],weeks[index],times[index],rooms[index],departments[index],seasons[index],cancelFlags[index]])
        performSegue(withIdentifier: "goBack", sender: nil)
    }
    
    
    
    //以下、検索バーの設定用項目。
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        lectureSeachBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText:String){
        //検索結果配列を空にする。
        searchResult.removeAll()
        
        if lectureSeachBar.text == "" {
            //検索文字列が空の場合はすべてを表示する。
            searchResult = names
        } else {
            //検索文字列を含むデータを検索結果配列に追加する。
            for name in names {
                if name.contains(lectureSeachBar.text!) {
                    searchResult.append(name)
                }
            }
        }
        //テーブルを再読み込みする。
        lectureSelectingTableView.reloadData()
    }
    
    //Segueの準備。
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goBack" {
            let previousViewController = segue.destination as! LectureSettingViewContoroller
            previousViewController.aPeriodLecture = senderLectureData
        }
    }
    
    //fetch
    func getLecturesData() {
        Alamofire.request("https://api.project-alt.tech/api/home/lectures", parameters: ["week":"\(weekday)", "time":"\(period+1)"]).responseJSON{response in
            guard let object = response.result.value else{
                print("error")
                return
            }
            let json = JSON(object)
            json.forEach { (_, json) in
                // ここに処理を書いていく
                self.ids.append(String(json["id"].intValue))
                self.names.append(json["name"].stringValue)
                self.teachers.append(json["teacher"].stringValue)
                self.weeks.append(String(json["week"].intValue))
                self.times.append(String(json["time"].intValue))
                self.rooms.append(json["room"].stringValue)
                self.seasons.append(String(json["period"].intValue))
                self.departments.append(String(json["department"].intValue))
                self.cancelFlags.append(String(json["cancel_flag"].boolValue))
            }
            self.searchResult = self.names
            self.lectureSelectingTableView.reloadData()
        }
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
