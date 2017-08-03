//
//  LectureSettingViewContoroller.swift
//  alt
//
//  Created by 岡田航汰 on 2017/07/27.
//  Copyright © 2017年 Kota Okada. All rights reserved.
//

import UIKit

class LectureSettingViewContoroller: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var lectureSettingContenairView: UIView!
    @IBOutlet weak var lectureSettingTableView: UITableView!
    
    var weekday = ["月曜日","火曜日","水曜日","木曜日","金曜日"]
    var aDayLecture:[[String]] = [["社会学概論","","","","","","社/基礎"],[],[],[],[]]
    var aWeekLecture:[[[String]]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.lectureSettingTableView.register(UINib(nibName: "LectureSettingTableViewCell", bundle:nil), forCellReuseIdentifier: "LectureSettingTableViewCellID")
        
        //セルの高さを40に指定
        lectureSettingTableView.rowHeight = 50
        lectureSettingTableView.backgroundColor = UIColor.clear
        
        //背景にグラデーションを作成
        lectureSettingContenairView.setGradientLayer(direction: "horizonal")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LectureSettingTableViewCellID", for: indexPath) as! LectureSettingTableViewCell
        cell.setLectureSettingCell(aDayLecture: aDayLecture, period: indexPath.row)
        return cell
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
