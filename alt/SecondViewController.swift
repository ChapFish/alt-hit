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
    
    let env = ProcessInfo.processInfo.environment
    
    var question = Question()
    
    var allQuestions:[Question] = []
    var unansweredQuestions:[Question] = []

    var searchedQuestions:[Question] = []
    var searchResult:[Question] = []
    
    var newPostMenuFlag = false
    var tabStatus = 0
    
    var senderQuestion = Question()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.voiceTableView.register(UINib(nibName: "QuestionWithAnswerCardTableViewCell", bundle:nil), forCellReuseIdentifier: "QuestionWithAnswerCardTableViewCellID")
        self.voiceTableView.register(UINib(nibName: "QuestionCardTableViewCell", bundle:nil), forCellReuseIdentifier: "QuestionCardTableViewCellID")
        self.voiceTableView.register(UINib(nibName: "TwoOptionCardTableViewCell", bundle:nil), forCellReuseIdentifier: "TwoOptionCardTableViewCellID")
        self.voiceTableView.register(UINib(nibName: "ThreeOptionCardTableViewCell", bundle:nil), forCellReuseIdentifier: "ThreeOptionCardTableViewCellID")
        self.voiceTableView.register(UINib(nibName: "FourOptionCardTableViewCell", bundle:nil), forCellReuseIdentifier: "FourOptionCardTableViewCellID")
        
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
        
        let newSurveyButtonTap = UITapGestureRecognizer(target: self, action: #selector(SecondViewController.tapNewSueveyButton(sender:)))
        newSurveyButtonTap.numberOfTapsRequired = 1
        self.newSurbeyButton.addGestureRecognizer(newSurveyButtonTap)
        
        getAllVoiceData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //選択されたセルの解除
        if let indexPathForSelectedRow = voiceTableView.indexPathForSelectedRow {
            voiceTableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
        newPostMenuFlag = false
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch searchResult[indexPath.row].questionStatus {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCardTableViewCellID", for: indexPath) as! QuestionCardTableViewCell
            cell.setQuestionCell(question: searchResult[indexPath.row].text)
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionWithAnswerCardTableViewCellID", for: indexPath) as! QuestionWithAnswerCardTableViewCell
            cell.setQuestionWithAnswerCell(question: searchResult[indexPath.row].text, answer: searchResult[indexPath.row].answers[0])
            return cell

            
        case 2:
            //選択肢の数ごとに使うセルを分ける
            switch searchResult[indexPath.row].optionCount {
            
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "TwoOptionCardTableViewCellID", for: indexPath) as! TwoOptionCardTableViewCell
                cell.setTwoOptionCell(question: searchResult[indexPath.row].text, options: searchResult[indexPath.row].options, results: searchResult[indexPath.row].optionValues, userAnswered: searchResult[indexPath.row].userAnsweredFlag)
                cell.questionID = searchResult[indexPath.row].id
                cell.indexAtTable = indexPath.row
                cell.deligate = self
                return cell

            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ThreeOptionCardTableViewCellID", for: indexPath) as! ThreeOptionCardTableViewCell
                cell.setThreeOptionCell(question: searchResult[indexPath.row].text, options: searchResult[indexPath.row].options, results: searchResult[indexPath.row].optionValues, userAnswered: searchResult[indexPath.row].userAnsweredFlag)
                cell.questionID = searchResult[indexPath.row].id
                cell.indexAtTable = indexPath.row
                cell.deligate = self
                return cell

            case 4:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FourOptionCardTableViewCellID", for: indexPath) as! FourOptionCardTableViewCell
                cell.setFourOptionCell(question: searchResult[indexPath.row].text, options: searchResult[indexPath.row].options, results: searchResult[indexPath.row].optionValues, userAnswered: searchResult[indexPath.row].userAnsweredFlag)
                cell.questionID = searchResult[indexPath.row].id
                cell.indexAtTable = indexPath.row
                cell.deligate = self
                return cell
                
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "TwoOptionCardTableViewCellID", for: indexPath) as! TwoOptionCardTableViewCell
                cell.setTwoOptionCell(question: searchResult[indexPath.row].text, options: searchResult[indexPath.row].options, results: searchResult[indexPath.row].optionValues, userAnswered: searchResult[indexPath.row].userAnsweredFlag)
                cell.questionID = searchResult[indexPath.row].id
                cell.indexAtTable = indexPath.row
                cell.deligate = self
                return cell
            }
            
        //書かないわけにはいかないからとりあえず未回答のもので。
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TwoOptionCardTableViewCellID", for: indexPath) as! TwoOptionCardTableViewCell
            cell.setTwoOptionCell(question: searchResult[indexPath.row].text, options: searchResult[indexPath.row].options, results: searchResult[indexPath.row].optionValues, userAnswered: searchResult[indexPath.row].userAnsweredFlag)
            cell.questionID = searchResult[indexPath.row].id
            cell.indexAtTable = indexPath.row
            cell.deligate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchResult[indexPath.row].questionStatus == 0{
            senderQuestion = searchResult[indexPath.row]
            performSegue(withIdentifier: "toQuestionDetail", sender: nil)
        }else if searchResult[indexPath.row].questionStatus == 1{
            senderQuestion = searchResult[indexPath.row]
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
    
    //searchbarの検索処理。
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getSearchedData(searchText: searchBar.text!)
        searchBar.endEditing(true)
    }
    
    //アンケート機能の選択肢タップ時の動作。
    func getOptionID(optionIndex: Int, questionID: Int, indexAtTable:Int) {
        answerSurvey(userID: 12345, questionID: questionID, optionIndex: optionIndex)
        searchResult[indexAtTable].userAnsweredFlag = true
        searchResult[indexAtTable].optionValues[optionIndex - 1] += 1
        let row = [IndexPath(row: indexAtTable, section: 0)]
        voiceTableView.reloadRows(at: row, with: UITableViewRowAnimation.fade)
    }
    
    //上部切り替え部分のタップの処理。
    //全質問表示のボタン
    @IBAction func tapAllQuestionButton(_ sender: Any) {
        tabStatus = 0
        self.allQuestionButton.setTitleColor(UIColor.colorFromRGB(rgb: "13A7A1", alpha: 1.0), for: .normal)
        self.unansweredQuestionButton.setTitleColor(UIColor.colorFromRGB(rgb: "95989A", alpha: 1.0), for: .normal)
        self.myQuestionButton.setTitleColor(UIColor.colorFromRGB(rgb: "95989A", alpha: 1.0), for: .normal)
        if allQuestions.isEmpty {
            getAllVoiceData()
        }else{
            searchResult = allQuestions
            voiceTableView.reloadData()
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.pageIndicator.center.x = UIScreen.main.bounds.size.width / 6
        }){_ in
            self.pageIndicator.center.x = UIScreen.main.bounds.size.width / 6
        }
    }
    //未回答質問表示のボタン
    @IBAction func tapUnansweredQuestionButton(_ sender: Any) {
        tabStatus = 1
        self.allQuestionButton.setTitleColor(UIColor.colorFromRGB(rgb: "95989A", alpha: 1.0), for: .normal)
        self.unansweredQuestionButton.setTitleColor(UIColor.colorFromRGB(rgb: "13A7A1", alpha: 1.0), for: .normal)
        self.myQuestionButton.setTitleColor(UIColor.colorFromRGB(rgb: "95989A", alpha: 1.0), for: .normal)
        if unansweredQuestions.isEmpty {
            getUnansweredData()
        }else{
            searchResult = unansweredQuestions
            voiceTableView.reloadData()
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.pageIndicator.center.x = UIScreen.main.bounds.size.width / 2
        }){_ in
            self.pageIndicator.center.x = UIScreen.main.bounds.size.width / 2
        }
    }
    //私の質問表示のボタン
    @IBAction func tapMyQuestionButton(_ sender: Any) {
        tabStatus = 2
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toQuestionDetail" {
            let secondViewController = segue.destination as! QuestionDetailViewController
            secondViewController.questionAndAnswers = senderQuestion
        }
    }
    
    func tapNewQuestionButton(sender: UITapGestureRecognizer){
        self.performSegue(withIdentifier: "toNewQuestion", sender: nil)
    }
    
    func tapNewSueveyButton(sender: UITapGestureRecognizer){
        self.performSegue(withIdentifier: "toNewSurvey", sender: nil)
    }
    
    //ここからサーバーサイドとの連携関連
    //fechの処理。
    func getAllVoiceData(){
        Alamofire.request("https://server.project-alt.tech/api/voice/voices", parameters: ["tab":"0"]).responseJSON{response in
            guard let object = response.result.value else{
                print("error")
                return
            }
            let json = JSON(object)
            print(json)
            json.forEach { (_, json) in
                self.perseQuestions(json: json)
                self.allQuestions.append(self.question)
            }
            self.searchResult = self.allQuestions
            self.voiceTableView.reloadData()
        }
    }
    
    func getUnansweredData(){
        Alamofire.request("https://server.project-alt.tech/api/voice/voices", parameters: ["tab":"1"]).responseJSON{response in
            guard let object = response.result.value else{
                print("error")
                return
            }
            let json = JSON(object)
            json.forEach { (_, json) in
                self.perseQuestions(json: json)
                self.unansweredQuestions.append(self.question)
            }
            self.searchResult = self.unansweredQuestions
            self.voiceTableView.reloadData()
        }
        
    }
    
    func getSearchedData(searchText:String){
        searchedQuestions.removeAll()
        Alamofire.request("https://server.project-alt.tech/api/voice/voices", parameters: ["tab":"\(tabStatus)","search":searchText]).responseJSON{response in
            guard let object = response.result.value else{
                print("error")
                return
            }
            let json = JSON(object)
            json.forEach { (_, json) in
                self.perseQuestions(json: json)
                self.searchedQuestions.append(self.question)
            }
            self.searchResult = self.searchedQuestions
            self.voiceTableView.reloadData()
        }
    }
    
    //fetchの処理の中身。
    func perseQuestions(json:JSON){
        
        question.resetQuestion()
        self.question.id = json["id"].intValue
        
        var questionStatus = 0
        if json["kind"].intValue == 1{
            questionStatus = 2
        } else if json["answered_flag"].boolValue {
            questionStatus = 1
        }
        self.question.questionStatus = questionStatus
        self.question.text = json["text"].stringValue
        if questionStatus == 1{
            for i in 0 ..< json["answers"].arrayValue.count{
                self.question.answers.append(json["answers"][i].stringValue)
            }
        }else if questionStatus == 2{
            self.question.optionCount = json["option_count"].intValue
            self.question.userAnsweredFlag = json["user_answered_flag"].boolValue
            for i in 0 ..< json["option_count"].intValue{
                self.question.options.append(json["enquete"][i]["option"].stringValue)
            }
            for i in 0 ..< json["option_count"].intValue{
                self.question.optionValues.append(json["enquete"][i]["answer"].intValue)
            }
        }
    }
    
    //アンケートに回答する
    func answerSurvey(userID:Int, questionID:Int, optionIndex:Int){
        if let APIPostKey = env["APIPostKey"]{
            let parameters:Parameters = ["user_id":userID, "question_id":questionID, "option_index":optionIndex - 1, "api_key":APIPostKey]
            Alamofire.request("https://server.project-alt.tech/api/voice/enq_answers", method: .post, parameters: parameters).responseJSON{response in
                if let json = response.result.value{
                    print(json)
                }else{
                    print("error")
                }
            }
        }
    }
}
