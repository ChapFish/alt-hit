//
//  DepartmentSettingViewController.swift
//  alt
//
//  Created by 岡田航汰 on 2017/10/09.
//  Copyright © 2017年 Kota Okada. All rights reserved.
//

import UIKit

class DepartmentSettingViewController: UIViewController {
    
    @IBOutlet weak var departmentSettingContainerView: UIView!
    @IBOutlet weak var departmentSaveButton: UIView!

    let userDefaults = UserDefaults.standard
    var userDepartment:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        departmentSettingContainerView.setGradientLayer(direction: "horizonal")
        departmentSettingContainerView.alpha = 0.7
        
        for i in 1 ... 4 {
            departmentSettingContainerView.viewWithTag(i)?.backgroundColor = UIColor.white
            departmentSettingContainerView.viewWithTag(i)?.addCardShadow()
            departmentSettingContainerView.viewWithTag(i)?.alpha = 0.75
        }
        departmentSettingContainerView.layer.shadowPath = UIBezierPath(rect: departmentSettingContainerView.bounds).cgPath
        departmentSettingContainerView.layer.shouldRasterize = true
        departmentSettingContainerView.layer.rasterizationScale = UIScreen.main.scale
        departmentSettingContainerView.layer.masksToBounds = false
        
        let saveButtonTap = UITapGestureRecognizer(target:self, action: #selector(self.tapSaveButton(sender: )))
        saveButtonTap.numberOfTapsRequired = 1
        self.departmentSaveButton.addGestureRecognizer(saveButtonTap)
        departmentSaveButton.addCardShadow()
        
        for i in 1 ... 4 {
            let departmentButtonTap = UITapGestureRecognizer(target:self, action: #selector(self.tapDepartmentButton(sender:)))
            departmentButtonTap.numberOfTapsRequired = 1
            departmentSettingContainerView.viewWithTag(i)?.addGestureRecognizer(departmentButtonTap)
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
            self.departmentSaveButton.alpha = 0.5
        }) {_ in
            self.departmentSaveButton.alpha = 1.0
        }
        if ((userDefaults.object(forKey: "userDepartment")) != nil){
            userDefaults.set(userDepartment, forKey: "userDepartment")
        }else{
            userDefaults.register(defaults: ["userDepartment":userDepartment])
        }
        performSegue(withIdentifier: "toGradeSetting", sender: nil)
    }
    
    func tapDepartmentButton(sender: UITapGestureRecognizer){
        for i in 1 ... 4 {
            departmentSettingContainerView.viewWithTag(i)?.alpha = 0.75
        }
        sender.view?.alpha = 1.0
        userDepartment = sender.view?.tag ?? 0
        print(userDepartment)
    }
    
}
