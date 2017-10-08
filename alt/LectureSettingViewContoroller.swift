//
//  LectureSettingViewContoroller.swift
//  alt
//
//  Created by 岡田航汰 on 2017/07/27.
//  Copyright © 2017年 Kota Okada. All rights reserved.
//

import UIKit
import RealmSwift

class LectureSettingViewContoroller: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var lectureSaveButton: UIView!
    @IBOutlet weak var lectureSaveButtonLabel: UILabel!
    @IBOutlet weak var lectureSettingContenairView: UIView!
    @IBOutlet weak var lectureSettingTableView: UITableView!
    @IBOutlet weak var lectureSettingMsgLabel: UILabel!
    
    //戻ってくるようのアクション
    @IBAction func goBack(_ segue:UIStoryboardSegue) {}
    
    var weekday = ["月曜日","火曜日","水曜日","木曜日","金曜日"]
    /*var aPeriodLecture:[String] = []
    var aDayLecture:[[String]] = [[],[],[],[],[]]
    var aWeekLecture:[[[String]]] = [[],[],[],[],[]]*/
    var aPeriodLecture = Lecture()
    var aDayLecture:[Lecture] = [Lecture(), Lecture(), Lecture(), Lecture(), Lecture()]
    var aWeekLecture:[[Lecture]] = [[],[],[],[],[]]
    var count:Int = 0
    // countは0から4までの整数値であり、今何曜日か示す。
    var senderPeriod = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.lectureSettingTableView.register(UINib(nibName: "LectureSettingTableViewCell", bundle:nil), forCellReuseIdentifier: "LectureSettingTableViewCellID")
        
        //セルの高さを40に指定
        lectureSettingTableView.rowHeight = 50
        lectureSettingTableView.backgroundColor = UIColor.clear
        
        //背景にグラデーションを作成
        lectureSettingContenairView.setGradientLayer(direction: "horizonal")
        lectureSettingContenairView.alpha = 0.7
        
        lectureSaveButtonLabel.text = "\(weekday[count+1])へ"
        lectureSettingMsgLabel.text = "\(weekday[count])の授業を教えてください。"
        
        
        let saveButtonTap = UITapGestureRecognizer(target:self, action: #selector(LectureSettingViewContoroller.tapSaveButton(sender: )))
        saveButtonTap.numberOfTapsRequired = 1
        self.lectureSaveButton.addGestureRecognizer(saveButtonTap)
        lectureSaveButton.addCardShadow()
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPathForSelectedRow = lectureSettingTableView.indexPathForSelectedRow {
            aDayLecture[indexPathForSelectedRow.row] = aPeriodLecture
            lectureSettingTableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
        self.lectureSettingTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //tableViewに必要なプロトコル。
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LectureSettingTableViewCellID", for: indexPath) as! LectureSettingTableViewCell
        cell.setLectureSettingCell(aDayLecture: aDayLecture, period: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        senderPeriod = indexPath.row
        performSegue(withIdentifier: "toNextView", sender: nil)
    }
    
    //Segueの準備。
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNextView" {
            let secondViewController = segue.destination as! LectureSelectingViewController
            secondViewController.period = senderPeriod
            secondViewController.weekday = count
        }
    }
    
    func tapSaveButton(sender: UITapGestureRecognizer){
        if count < 4 {
            UIView.animate(withDuration: 0.3, animations: {
            //透明度の変わるアニメーション
                self.lectureSaveButton.alpha = 0.5
            }) {_ in
                self.lectureSaveButton.alpha = 1.0
            }
            //配列に時間割を保存
            aWeekLecture[count] = aDayLecture
            aDayLecture = [Lecture(), Lecture(), Lecture(), Lecture(), Lecture()]
            
            //ボタンの表示を変更
            count = count + 1
            lectureSettingMsgLabel.text = "\(weekday[count])の授業を教えてください。"
            if count < 4{
                self.lectureSaveButtonLabel.text = "\(weekday[count+1])へ"
            }else{
                self.lectureSaveButtonLabel.text = "保存"
            }
            self.lectureSettingTableView.reloadData()
        }else{
            //ここに保存の処理を書く。
            aWeekLecture[count] = aDayLecture
            print(aWeekLecture)
            
            let realm = try! Realm()
            for dayIndex in 0...4{
                aDayLecture = aWeekLecture[dayIndex]
                for periodIndex in 0...4{
                    aPeriodLecture = aDayLecture[periodIndex]
                    if aPeriodLecture.id == 0{
                        // 授業がない場合は曜日と時限のみ入ったからのデータを保存する。
                        let theLecture = RealmLecture(value: [0, "", "", dayIndex, periodIndex+1, "", 0, 0, false])
                        //保存
                        try! realm.write {
                            realm.add(theLecture)
                        }
                    }else{
                        //授業がある場合はそれぞれ対応するデータを入力。
                        let theLecture = RealmLecture()
                        theLecture.id = aPeriodLecture.id
                        theLecture.name = aPeriodLecture.name
                        theLecture.teacher = aPeriodLecture.teacher
                        theLecture.week = aPeriodLecture.week
                        theLecture.time = aPeriodLecture.time
                        theLecture.room = aPeriodLecture.room
                        theLecture.season = aPeriodLecture.season
                        theLecture.department = aPeriodLecture.department
                        theLecture.cancelFlag = aPeriodLecture.cancelFlag
                        //保存
                        try! realm.write {
                            realm.add(theLecture)
                        }
                    }
                }
            }
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
