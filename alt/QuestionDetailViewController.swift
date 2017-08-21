//
//  QuestionDetailViewController.swift
//  alt
//
//  Created by 岡田航汰 on 2017/08/21.
//  Copyright © 2017年 Kota Okada. All rights reserved.
//

import UIKit

class QuestionDetailViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var questionDetailTableView: UITableView!
    @IBOutlet weak var inputContainerView: UIView!
    @IBOutlet weak var inputContainerViewBottom: NSLayoutConstraint!
    
    var questionAndAnswers:Array<String> = ["123", "0", "ゼミ面接はスーツで行ったほうがいいんでしょうか。"]
    //[id,status,question,answer1,answer2...]
    var question:String = ""
    var answers:Array<String> = []
    var unanswered:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.questionDetailTableView.register(UINib(nibName: "QuestionCardTableViewCell", bundle:nil), forCellReuseIdentifier: "QuestionCardTableViewCellID")
        
        // キーボードが開いたことを伝えてadjustForKeyboardを起動。
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        //TableViewの初期設定
        self.questionDetailTableView.estimatedRowHeight = 200
        self.questionDetailTableView.rowHeight = UITableViewAutomaticDimension
        self.questionDetailTableView.backgroundColor = UIColor.colorFromRGB(rgb: "EBEBEB", alpha: 1.0)
        
        //必要な形にデータを整形。
        question = questionAndAnswers[2]
        for i in 3 ..< questionAndAnswers.count{
            answers.append(questionAndAnswers[i])
        }
        if questionAndAnswers[1] == "0"{
            unanswered = true
        }else{
            unanswered = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCardTableViewCellID", for: indexPath) as! QuestionCardTableViewCell
        cell.setQuestionCell(question: question, unanswered: unanswered, msg: false)
        return cell
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

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
