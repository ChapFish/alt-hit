//
//  LectureSelectingViewController.swift
//  alt
//
//  Created by 岡田航汰 on 2017/08/03.
//  Copyright © 2017年 Kota Okada. All rights reserved.
//

import UIKit

class LectureSelectingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    //実験用定数
    let names = ["社会学概論", "経済学入門", "法学入門", "金融フロンティア論", "社会倫理学", "経済史入門", "原価計算"]
    let departments = ["社会学部", "経済学部" ,"一般教養科目", "商学部", "社会学部", "経済学部", "商学部"]
    var departmentsDic:[String:String] = [:]
    //検索結果を入れる
    var searchResult:[String] = []
    
    @IBAction func cancelButton(_ sender: Any) {
        performSegue(withIdentifier: "goBack", sender: nil)
    }
    @IBOutlet weak var lectureSeachBar: UISearchBar!
    @IBOutlet weak var lectureSelectingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //サーチバーの初期設定
        lectureSeachBar.delegate = self
        lectureSeachBar.enablesReturnKeyAutomatically = false
        searchResult = names
        self.lectureSeachBar.layer.borderColor = UIColor.white.cgColor
        self.lectureSeachBar.layer.borderWidth = 1.0
        
        /* こっから実験
        for i in 0 ..< names.count {
            departmentsDic[names[i]] = departments[i]
        }*/
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
