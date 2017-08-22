//
//  SecondViewController.swift
//  alt
//
//  Created by 岡田航汰 on 2017/07/16.
//  Copyright © 2017年 Kota Okada. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, TapOptionDeligate {

    

    @IBOutlet weak var voiceSearchBar: UISearchBar!
    @IBOutlet weak var voiceTableView: UITableView!
    @IBOutlet weak var newSurbeyButton: UIView!
    @IBOutlet weak var newQuestionButton: UIView!
    @IBOutlet weak var newPostMenu: UIView!
    @IBOutlet weak var allQuestionButton: UIButton!
    @IBOutlet weak var unansweredQuestionButton: UIButton!
    @IBOutlet weak var myQuestionButton: UIButton!
    @IBOutlet weak var pageIndicator: UIView!
    
    @IBAction func goBack(_ segue:UIStoryboardSegue) {}
    
    var question:[String] = []
    
    var allQuestions:[[String]] = []
    var unansweredQuestions:[[String]] = []
    var searchResult:[[String]] = []
    
    var newPostMenuFlag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.voiceTableView.register(UINib(nibName: "QuestionWithAnswerCardTableViewCell", bundle:nil), forCellReuseIdentifier: "QuestionWithAnswerCardTableViewCellID")
        self.voiceTableView.register(UINib(nibName: "QuestionCardTableViewCell", bundle:nil), forCellReuseIdentifier: "QuestionCardTableViewCellID")
        self.voiceTableView.register(UINib(nibName: "SurveyQuestionCardTableViewCell", bundle:nil), forCellReuseIdentifier: "SurveyQuestionCardTableViewCellID")
        self.voiceTableView.register(UINib(nibName: "SurveyResultCardTableViewCell", bundle:nil), forCellReuseIdentifier: "SurveyResultCardTableViewCellID")

        
        //TableViewの初期設定
        self.voiceTableView.estimatedRowHeight = 200
        self.voiceTableView.rowHeight = UITableViewAutomaticDimension
        self.voiceTableView.backgroundColor = UIColor.colorFromRGB(rgb: "EBEBEB", alpha: 1.0)
        
        //SearchBarの初期設定
        self.voiceSearchBar.layer.borderColor = UIColor.white.cgColor
        self.voiceSearchBar.layer.borderWidth = 1.0
        
        //ボタン部分の見た目の設定
        self.newPostMenu.setGradientLayer(direction: "tilt")
        self.newSurbeyButton.setGradientLayer(direction: "tilt")
        self.newQuestionButton.setGradientLayer(direction: "tilt")

        self.newPostMenu.layer.cornerRadius = 27
        self.newPostMenu.clipsToBounds = true
        self.newSurbeyButton.layer.cornerRadius = 20
        self.newSurbeyButton.clipsToBounds = true
        self.newQuestionButton.layer.cornerRadius = 20
        self.newQuestionButton.clipsToBounds = true
        
        let newPostMenuTap = UITapGestureRecognizer(target:self, action: #selector(SecondViewController.tapNewPostMenu(sender: )))
        newPostMenuTap.numberOfTapsRequired = 1
        self.newPostMenu.addGestureRecognizer(newPostMenuTap)
        
        let newQuestionButtonTap = UITapGestureRecognizer(target:self, action: #selector(SecondViewController.tapNewQuestionButton(sender:)))
        newQuestionButtonTap.numberOfTapsRequired = 1
        self.newQuestionButton.addGestureRecognizer(newQuestionButtonTap)
        
        getAllVoiceData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //選択されたセルの解除
        if let indexPathForSelectedRow = voiceTableView.indexPathForSelectedRow {
            voiceTableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return searchResult.count
    }
    
    //tableViewDeligateの必須プロトコル。
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch searchResult[indexPath.row][1] {
        case "0":
            //[id,status,question]
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCardTableViewCellID", for: indexPath) as! QuestionCardTableViewCell
            cell.setQuestionCell(question: searchResult[indexPath.row][2])
            return cell
            
        case "1":
            //[id,status,question,answer1,answer2...]
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionWithAnswerCardTableViewCellID", for: indexPath) as! QuestionWithAnswerCardTableViewCell
            cell.setQuestionWithAnswerCell(question: searchResult[indexPath.row][2], answer: searchResult[indexPath.row][3])
            return cell

            
        case "2":
            //[id,status,question,optionCount,option1,option2...]
            let cell = tableView.dequeueReusableCell(withIdentifier: "SurveyQuestionCardTableViewCellID", for: indexPath) as! SurveyQuestionCardTableViewCell
            var options: Array<String> = []
            if let optionCount = Int(searchResult[indexPath.row][3]){
                for i in 4 ..< optionCount{
                    options.append(searchResult[indexPath.row][i])
                }
            }
            cell.setSurveyQuestionCell(question: searchResult[indexPath.row][2], options: options, count: options.count)
            cell.deligate = self
            return cell
            
        case "3":
            //[id,status,question,optionCount,option1,option2...,answer1,answer2...]
            let cell = tableView.dequeueReusableCell(withIdentifier: "SurveyResultCardTableViewCellID", for: indexPath) as! SurveyResultCardTableViewCell
            var options: Array<String> = []
            var results: Array<Int> = []
            if let optionCount = Int(searchResult[indexPath.row][3]){
                for i in 4 ..< optionCount{
                    options.append(searchResult[indexPath.row][i])
                    results.append(Int(searchResult[indexPath.row][i + optionCount])!)
                }
            }
            cell.setSurveyResultCell(question: searchResult[indexPath.row][2], options: options, results: results, count: options.count)
            return cell
        
        //書かないわけにはいかないからとりあえず未回答のもので。
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCardTableViewCellID", for: indexPath) as! QuestionCardTableViewCell
            cell.setQuestionCell(question: searchResult[indexPath.row][2])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchResult[indexPath.row][1] == "0"{
            performSegue(withIdentifier: "toQuestionDetail", sender: nil)
        }else if searchResult[indexPath.row][2] == "1"{
            performSegue(withIdentifier: "toQuestionDetail", sender: nil)
        }
    }
    
    //tableViewの一番上に余白を空けるために、セクションヘッダーを追加。
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    //アンケート機能の選択肢タップ時の動作。
    func getOptionID(optionID: Int) {
        print(optionID)
    }
    
    //上部切り替え部分のタップの処理。
    @IBAction func tapAllQuestionButton(_ sender: Any) {
        self.allQuestionButton.setTitleColor(UIColor.colorFromRGB(rgb: "13A7A1", alpha: 1.0), for: .normal)
        self.unansweredQuestionButton.setTitleColor(UIColor.colorFromRGB(rgb: "95989A", alpha: 1.0), for: .normal)
        self.myQuestionButton.setTitleColor(UIColor.colorFromRGB(rgb: "95989A", alpha: 1.0), for: .normal)
        UIView.animate(withDuration: 0.3, animations: {
            self.pageIndicator.center.x = UIScreen.main.bounds.size.width / 6
        }){_ in
            self.pageIndicator.center.x = UIScreen.main.bounds.size.width / 6
        }
    }
    @IBAction func tapUnansweredQuestionButton(_ sender: Any) {
        self.allQuestionButton.setTitleColor(UIColor.colorFromRGB(rgb: "95989A", alpha: 1.0), for: .normal)
        self.unansweredQuestionButton.setTitleColor(UIColor.colorFromRGB(rgb: "13A7A1", alpha: 1.0), for: .normal)
        self.myQuestionButton.setTitleColor(UIColor.colorFromRGB(rgb: "95989A", alpha: 1.0), for: .normal)
        UIView.animate(withDuration: 0.3, animations: {
            self.pageIndicator.center.x = UIScreen.main.bounds.size.width / 2
        }){_ in
            self.pageIndicator.center.x = UIScreen.main.bounds.size.width / 2
        }
    }
    @IBAction func tapMyQuestionButton(_ sender: Any) {
        self.allQuestionButton.setTitleColor(UIColor.colorFromRGB(rgb: "95989A", alpha: 1.0), for: .normal)
        self.unansweredQuestionButton.setTitleColor(UIColor.colorFromRGB(rgb: "95989A", alpha: 1.0), for: .normal)
        self.myQuestionButton.setTitleColor(UIColor.colorFromRGB(rgb: "13A7A1", alpha: 1.0), for: .normal)
        UIView.animate(withDuration: 0.3, animations: {
            self.pageIndicator.center.x = UIScreen.main.bounds.size.width * 5 / 6
        }){_ in
            self.pageIndicator.center.x = UIScreen.main.bounds.size.width * 5 / 6
        }
    }

    //右下部のボタン押下処理。
    func tapNewPostMenu(sender: UITapGestureRecognizer){
        if newPostMenuFlag {
            UIView.animate(withDuration: 0.3,animations:{
                self.newSurbeyButton.center.y += 62
            }, completion: nil)
            UIView.animate(withDuration: 0.3, animations:{
                self.newQuestionButton.center.y += 117
            }, completion: nil)
            newPostMenuFlag = false
        }else{
            UIView.animate(withDuration: 0.3, animations:{
                self.newSurbeyButton.center.y -= 62
            }, completion: nil)
            UIView.animate(withDuration: 0.3, animations:{
                self.newQuestionButton.center.y -= 117
            }, completion: nil)
            newPostMenuFlag = true
        }
    }
    
    func tapNewQuestionButton(sender: UITapGestureRecognizer){
        self.performSegue(withIdentifier: "toNewQuestion", sender: nil)
    }
    
    //fechの処理。
    func getAllVoiceData(){
        Alamofire.request("https://server.project-alt.tech/api/voice", parameters: ["":""]).responseJSON{response in
            guard let object = response.result.value else{
                print("error")
                return
            }
            let json = JSON(object)
            print(json)
            json.forEach { (_, json) in
                // ここに処理を書いていく
                self.question.removeAll()
                self.question.append(String(json["id"].intValue))
                
                var questionStatus = 0
                if json["kind"].intValue == 1{
                    questionStatus = 2
                } else if json["answered_flag"].boolValue {
                    questionStatus = 1
                }
                self.question.append(String(questionStatus))
                self.question.append(json["text"].stringValue)
                if questionStatus == 1{
                    for i in 0 ..< json["answers"].arrayValue.count{
                        self.question.append(json["answers"][i].stringValue)
                    }
                }else if questionStatus == 2{
                    self.question.append(String(json["option_count"].intValue))
                    for i in 0 ..< json["option_count"].intValue{
                        self.question.append(json["enquete"][i]["option"].stringValue)
                    }
                    for i in 0 ..< json["option_count"].intValue{
                        self.question.append(json["enquete"][i]["answer"].stringValue)
                    }
                }
                // もし自分が回答済みの場合は、questionStatusを3にすること！
                
                self.allQuestions.append(self.question)
            }
            print(self.allQuestions)

            self.searchResult = self.allQuestions
            self.voiceTableView.reloadData()
        }
    }
    
    func getUnansweredData(){
        Alamofire.request("URL", parameters: ["":""]).responseJSON{response in
            guard let object = response.result.value else{
                print("error")
                return
            }
            let json = JSON(object)
            json.forEach { (_, json) in
                self.question.removeAll()
                self.question.append(String(json["id"].intValue))
                self.question.append("0")
                self.question.append(json["text"].stringValue)
                self.unansweredQuestions.append(self.question)
            }
        }
    }
    
}
