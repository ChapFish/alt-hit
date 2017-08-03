//
//  LectureSettingViewContoroller.swift
//  alt
//
//  Created by 岡田航汰 on 2017/07/27.
//  Copyright © 2017年 Kota Okada. All rights reserved.
//

import UIKit

class LectureSettingViewContoroller: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var lectureSaveButton: UIView!
    @IBOutlet weak var lectureSaveButtonLabel: UILabel!
    @IBOutlet weak var lectureSettingContenairView: UIView!
    @IBOutlet weak var lectureSettingTableView: UITableView!
    
    var weekday = ["月曜日","火曜日","水曜日","木曜日","金曜日"]
    var aDayLecture:[[String]] = [[],[],[],[],[]]
    var aWeekLecture:[[[String]]] = [[],[],[],[],[]]
    var count:Int = 0
    // countは0から4までの整数値であり、今何曜日か示す。
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.lectureSettingTableView.register(UINib(nibName: "LectureSettingTableViewCell", bundle:nil), forCellReuseIdentifier: "LectureSettingTableViewCellID")
        
        //セルの高さを40に指定
        lectureSettingTableView.rowHeight = 50
        lectureSettingTableView.backgroundColor = UIColor.clear
        
        //背景にグラデーションを作成
        lectureSettingContenairView.setGradientLayer(direction: "horizonal")
        
        lectureSaveButtonLabel.text = "\(weekday[count+1])へ"
        
        let saveButtonTap = UITapGestureRecognizer(target:self, action: #selector(LectureSettingViewContoroller.tapSaveButton(sender: )))
        saveButtonTap.numberOfTapsRequired = 1
        self.lectureSaveButton.addGestureRecognizer(saveButtonTap)
        
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
            aDayLecture = [[],[],[],[],[]]
            //ボタンの表示を変更
            count = count + 1
            if count < 4{
                self.lectureSaveButtonLabel.text = "\(weekday[count+1])へ"
            }else{
                self.lectureSaveButtonLabel.text = "保存"
            }
            self.lectureSettingTableView.reloadData()
        }else{
            //ここに保存の処理を書く。
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
