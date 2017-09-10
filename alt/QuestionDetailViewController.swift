//
//  QuestionDetailViewController.swift
//  alt
//
//  Created by 岡田航汰 on 2017/08/21.
//  Copyright © 2017年 Kota Okada. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class QuestionDetailViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var questionDetailTableView: UITableView!
    @IBOutlet weak var inputContainerView: UIView!
    @IBOutlet weak var inputContainerViewBottom: NSLayoutConstraint!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    
    let env = ProcessInfo.processInfo.environment
    
    var questionAndAnswers = Question()
    var unanswered:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.questionDetailTableView.register(UINib(nibName: "QuestionCardTableViewCell", bundle:nil), forCellReuseIdentifier: "QuestionCardTableViewCellID")
        self.questionDetailTableView.register(UINib(nibName: "AnswerCardTableViewCell", bundle:nil), forCellReuseIdentifier: "AnswerCardTableViewCellID")
        
        // キーボードが開いたことを伝えてadjustForKeyboardを起動。
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        //TableViewの初期設定
        self.questionDetailTableView.estimatedRowHeight = 200
        self.questionDetailTableView.rowHeight = UITableViewAutomaticDimension
        self.questionDetailTableView.backgroundColor = UIColor.colorFromRGB(rgb: "EBEBEB", alpha: 1.0)
        
        //質問に回答済みかどうかを判断
        if questionAndAnswers.questionStatus == 0{
            unanswered = true
        }else{
            unanswered = false
        }
        
        submitButton.isEnabled = false
        answerTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + questionAndAnswers.answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCardTableViewCellID", for: indexPath) as! QuestionCardTableViewCell
            cell.setQuestionCell(question: questionAndAnswers.text, unanswered: unanswered, msg: false)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCardTableViewCellID", for: indexPath) as! AnswerCardTableViewCell
            cell.setAnswerCell(answer: questionAndAnswers.answers[indexPath.row - 1])
            return cell
        }
    }
    
    //tableViewの一番上に余白を空けるために、セクションヘッダーを追加。
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    dynamic func adjustForKeyboard(notification:NSNotification){
        if notification.name == Notification.Name.UIKeyboardWillHide{
            self.inputContainerViewBottom.constant = 0
        }else{
            let newHeight = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size.height
            self.inputContainerViewBottom.constant = newHeight
        }
    }
    
    func textFieldEditingChanged(){
        if answerTextField.text == ""{
            submitButton.isEnabled = false
        }else{
            submitButton.isEnabled = true
        }
    }
    
    @IBAction func tapSubmitButton(_ sender: Any) {
        answerTextField.resignFirstResponder()

        if let APIPostKey = env["APIPostKey"]{
            let parameters:Parameters = ["question_id":questionAndAnswers.id, "text":answerTextField.text!, "user_id":"12345", "api_key":APIPostKey]
            Alamofire.request("https://server.project-alt.tech/api/voice/answers", method: .post, parameters: parameters).responseJSON{ response in
                if let json = response.result.value{
                    print(json)
                }else{
                    print("error1")
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    Alamofire.request("https://server.project-alt.tech/api/voice/voices/\(self.questionAndAnswers.id)").responseJSON{response in
                        guard let object = response.result.value else{
                            print("error2")
                            return
                        }
                        let json = JSON(object)
                        self.questionAndAnswers.questionStatus = 1
                        self.questionAndAnswers.answers.removeAll()
                        for i in 0 ..< json["answers"].arrayValue.count{
                            self.questionAndAnswers.answers.append(json["answers"][i].stringValue)
                        }
                        self.questionDetailTableView.reloadData()
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
