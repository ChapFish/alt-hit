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
    
    @IBAction func goBack(_ segue:UIStoryboardSegue) {}

    
    var question:[String] = []
    var allQuestions:[[String]] = []
    var unansweredQuestions:[[String]] = []
    let testQuestions:[[String]] = [["0","みなさん毎週どのくらいの時間をゼミの予習に使っていますか？"],["1","今年の一橋祭の参加申し込みはもうありましたか？","はい。夏学期の終わりにありました。これから参加したい場合は委員さんに相談するのをお勧めします。"],["2","ゼミ面接はスーツで行った方がよろしいでしょうか","カジュアルな私服で行った","綺麗めな服装で行った","スーツで行った"]]
    
    var newPostMenuFlag = false
    
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
    
    //アンケート機能の選択肢タップ時の動作。
    func getOptionID(optionID: Int) {
        print(optionID)
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
        Alamofire.request("https://54ca5c07.ngrok.io/voice/voices"/*, parameters: ["":""]*/).responseJSON{response in
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
            //self.voiceTableView.reloadData()
            print(self.allQuestions)
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
