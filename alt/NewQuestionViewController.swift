//
//  NewQuestionViewController.swift
//  alt
//
//  Created by 岡田航汰 on 2017/08/14.
//  Copyright © 2017年 Kota Okada. All rights reserved.
//

import UIKit
import Alamofire

class NewQuestionViewController: UIViewController, UITextViewDelegate {

    @IBAction func tapSubmitButton(_ sender: Any) {
        guard let submitQuestionText = newQuestionTextView.text else{
            return
        }
        let parameters:Parameters = ["kind":"0","text":"\(submitQuestionText)","user_id":"12345"]
        Alamofire.request("https://server.project-alt.tech/api/voice/questions", method: .post, parameters: parameters).responseJSON{ response in
            if let json = response.result.value{
                print(json)
            }else{
                print("error")
            }
        }
        performSegue(withIdentifier: "goBackVoice", sender: nil)
    }
    @IBAction func tapCancelButton(_ sender: Any) {
        performSegue(withIdentifier: "goBackVoice", sender: nil)
    }
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var newQuestionTextView: UITextView!
    @IBOutlet weak var textCountLabel: UILabel!
    
    var textCount:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        submitButton.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textCount = newQuestionTextView.text.characters.count
        textCountLabel.text = ("\(textCount)/100")
        if textCount > 0{
            submitButton.isEnabled = true
        }else{
            submitButton.isEnabled = false
        }
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        newQuestionTextView.text = nil
        newQuestionTextView.textColor = UIColor.black
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
