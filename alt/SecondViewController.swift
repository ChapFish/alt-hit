//
//  SecondViewController.swift
//  alt
//
//  Created by 岡田航汰 on 2017/07/16.
//  Copyright © 2017年 Kota Okada. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, TapOptionDeligate {

    @IBOutlet weak var voiceSearchBar: UISearchBar!
    @IBOutlet weak var voiceTableView: UITableView!
    
    let testQuestions:[[String]] = [["0","みなさん毎週どのくらいの時間をゼミの予習に使っていますか？"],["1","今年の一橋祭の参加申し込みはもうありましたか？","はい。夏学期の終わりにありました。これから参加したい場合は委員さんに相談するのをお勧めします。"],["2","ゼミ面接はスーツで行った方がよろしいでしょうか","カジュアルな私服で行った","綺麗めな服装で行った","スーツで行った"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.voiceTableView.register(UINib(nibName: "QuestionWithAnswerCardTableViewCell", bundle:nil), forCellReuseIdentifier: "QuestionWithAnswerCardTableViewCellID")
        self.voiceTableView.register(UINib(nibName: "QuestionCardTableViewCell", bundle:nil), forCellReuseIdentifier: "QuestionCardTableViewCellID")
        self.voiceTableView.register(UINib(nibName: "SurveyQuestionCardTableViewCell", bundle:nil), forCellReuseIdentifier: "SurveyQuestionCardTableViewCellID")
        
        //TableViewの初期設定
        self.voiceTableView.estimatedRowHeight = 200
        self.voiceTableView.rowHeight = UITableViewAutomaticDimension
        self.voiceTableView.backgroundColor = UIColor.colorFromRGB(rgb: "EBEBEB", alpha: 1.0)
        
        //SearchBarの初期設定
        self.voiceSearchBar.layer.borderColor = UIColor.white.cgColor
        self.voiceSearchBar.layer.borderWidth = 1.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return testQuestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch testQuestions[indexPath.row][0] {
        case "0":
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCardTableViewCellID", for: indexPath) as! QuestionCardTableViewCell
            cell.setQuestionCell(question: testQuestions[indexPath.row][1])
            return cell
            
        case "1":
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionWithAnswerCardTableViewCellID", for: indexPath) as! QuestionWithAnswerCardTableViewCell
            cell.setQuestionWithAnswerCell(question: testQuestions[indexPath.row][1], answer: testQuestions[indexPath.row][2])
            return cell

            
        case "2":
            let cell = tableView.dequeueReusableCell(withIdentifier: "SurveyQuestionCardTableViewCellID", for: indexPath) as! SurveyQuestionCardTableViewCell
            let options = [testQuestions[indexPath.row][2],testQuestions[indexPath.row][3],testQuestions[indexPath.row][4]]
            cell.setSurveyQuestionCell(question: testQuestions[indexPath.row][1], options: options)
            cell.deligate = self
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCardTableViewCellID", for: indexPath) as! QuestionCardTableViewCell
            cell.setQuestionCell(question: testQuestions[indexPath.row][1])
            return cell
        }
    }
    
    func getOptionID(optionID: Int) {
        print(optionID)
    }
}
