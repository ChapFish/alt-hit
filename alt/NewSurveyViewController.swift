//
//  NewSurveyViewController.swift
//  alt
//
//  Created by 岡田航汰 on 2017/08/27.
//  Copyright © 2017年 Kota Okada. All rights reserved.
//

import UIKit
import Alamofire

class NewSurveyViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    @IBAction func tapCancelButton(_ sender: Any) {
        performSegue(withIdentifier: "goBackVoice", sender: nil)
            }
    @IBAction func tapSubmitButton(_ sender: Any) {
        guard let submitQuestionText = newSurveyTextView.text else{
            return
        }
        var submitOptions:[String] = []
        if let aSubmitOption = aOption.text{
            submitOptions.append(aSubmitOption)
        }
        if let bSubmitOption = bOption.text{
            submitOptions.append(bSubmitOption)
        }
        if let cSubmitOption = cOption.text{
            if cSubmitOption != ""{
                submitOptions.append(cSubmitOption)
            }
        }
        if let dSubmitOption = dOption.text{
            if dSubmitOption != ""{
                submitOptions.append(dSubmitOption)
            }
        }
        
        if let APIPostKey = env["APIPostKey"]{
            let parameters:Parameters = ["kind":"1","text":submitQuestionText,"user_id":"12345","options":submitOptions,"api_key":APIPostKey]
            Alamofire.request("https://server.project-alt.tech/api/voice/questions", method: .post, parameters: parameters).responseJSON{ response in
                if let json = response.result.value{
                    print(json)
                }else{
                    print("error")
                }
            }
        }
        //performSegue(withIdentifier: "goBackVoice", sender: nil)
    }
    
    @IBOutlet weak var newSurveyContainerView: UIView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var newSurveyTextView: UITextView!    
    @IBOutlet weak var newSurveyTextContainerView: UIView!
    @IBOutlet weak var aOption: UITextField!
    @IBOutlet weak var bOption: UITextField!
    @IBOutlet weak var cOption: UITextField!
    @IBOutlet weak var dOption: UITextField!
    
    let env = ProcessInfo.processInfo.environment
    
    var textCount:Int = 0
    var aOptionCount:Int = 0
    var bOptionCount:Int = 0
    var activeTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        newSurveyContainerView.addCardShadow()
        self.newSurveyContainerView.layer.shadowPath = UIBezierPath(rect: self.newSurveyContainerView.bounds).cgPath
        self.newSurveyContainerView.layer.shouldRasterize = true
        self.newSurveyContainerView.layer.rasterizationScale = UIScreen.main.scale
        self.newSurveyContainerView.layer.masksToBounds = false

        self.newSurveyTextContainerView.addBorderBottom(color: "EBEBEB", margin: 25)
        
        aOption.layer.borderWidth = 1.0
        aOption.layer.borderColor = UIColor.lightGray.cgColor
        bOption.layer.borderWidth = 1.0
        bOption.layer.borderColor = UIColor.lightGray.cgColor
        cOption.layer.borderWidth = 1.0
        cOption.layer.borderColor = UIColor.lightGray.cgColor
        dOption.layer.borderWidth = 1.0
        dOption.layer.borderColor = UIColor.lightGray.cgColor
        
        // 入力欄にインデントを入れる
        aOption.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 5))
        aOption.leftViewMode = .always
        bOption.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 5))
        bOption.leftViewMode = .always
        cOption.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 5))
        cOption.leftViewMode = .always
        dOption.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 5))
        dOption.leftViewMode = .always
        
        aOption.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        bOption.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        
        submitButton.isEnabled = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if inputCompleted() {
            submitButton.isEnabled = true
        }else{
            submitButton.isEnabled = false
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if newSurveyTextView.text == "質問を入力してください"{
            newSurveyTextView.text = nil
            newSurveyTextView.textColor = UIColor.black
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.layer.borderColor = UIColor.colorFromRGB(rgb: "13A7A1", alpha: 1.0).cgColor
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        textField.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func textFieldEditingChanged(sender: UITextField){
        if inputCompleted(){
            submitButton.isEnabled = true
        }else{
            submitButton.isEnabled = false
        }
    }
    
    // 質問文と少なくとも２つの選択肢が入力されているかどうか判定。
    func inputCompleted () -> Bool{
        textCount = newSurveyTextView.text.characters.count
        if textCount > 0 && aOption.text != "" && bOption.text != ""{
            return true
        }else{
            return false
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
