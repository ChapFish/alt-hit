//
//  GradeSettingViewController.swift
//  alt
//
//  Created by 岡田航汰 on 2017/09/10.
//  Copyright © 2017年 Kota Okada. All rights reserved.
//

import UIKit

class GradeSettingViewController: UIViewController {
    
    @IBOutlet weak var gradeSettingContainerView: UIView!
    @IBOutlet weak var gradeSaveButton: UIView!
    
    let userDefaults = UserDefaults.standard
    var userGrade:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        gradeSettingContainerView.setGradientLayer(direction: "horizonal")
        gradeSettingContainerView.alpha = 0.7
        
        for i in 1 ... 4 {
            gradeSettingContainerView.viewWithTag(i)?.backgroundColor = UIColor.white
            gradeSettingContainerView.viewWithTag(i)?.addCardShadow()
            gradeSettingContainerView.viewWithTag(i)?.alpha = 0.75
        }
        gradeSettingContainerView.layer.shadowPath = UIBezierPath(rect: gradeSettingContainerView.bounds).cgPath
        gradeSettingContainerView.layer.shouldRasterize = true
        gradeSettingContainerView.layer.rasterizationScale = UIScreen.main.scale
        gradeSettingContainerView.layer.masksToBounds = false
        
        let saveButtonTap = UITapGestureRecognizer(target:self, action: #selector(self.tapSaveButton(sender: )))
        saveButtonTap.numberOfTapsRequired = 1
        self.gradeSaveButton.addGestureRecognizer(saveButtonTap)
        gradeSaveButton.addCardShadow()

        for i in 1 ... 4 {
            let gradeButtonTap = UITapGestureRecognizer(target:self, action: #selector(self.tapGradeButton(sender:)))
            gradeButtonTap.numberOfTapsRequired = 1
            gradeSettingContainerView.viewWithTag(i)?.addGestureRecognizer(gradeButtonTap)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func tapSaveButton(sender: UITapGestureRecognizer){
        UIView.animate(withDuration: 0.3, animations: {
        //透明度の変わるアニメーション
            self.gradeSaveButton.alpha = 0.5
        }) {_ in
            self.gradeSaveButton.alpha = 1.0
        }
        if ((userDefaults.object(forKey: "userGrade")) != nil){
            userDefaults.set(userGrade, forKey: "userGrade")
        }else{
            userDefaults.register(defaults: ["userGrade":userGrade])
        }
        performSegue(withIdentifier: "toLectureSetting", sender: nil)
    }
    
    func tapGradeButton(sender: UITapGestureRecognizer){
        for i in 1 ... 4 {
            gradeSettingContainerView.viewWithTag(i)?.alpha = 0.75
        }
        sender.view?.alpha = 1.0
        userGrade = sender.view?.tag ?? 0
        print(userGrade)
    }
    
}
