//
//  AltTabBarController.swift
//  alt
//
//  Created by 岡田航汰 on 2017/07/25.
//  Copyright © 2017年 Kota Okada. All rights reserved.
//

import UIKit

class AltTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UITabBar.appearance().barTintColor = UIColor.colorFromRGB(rgb: "068DC4", alpha: 1.0)
        UITabBar.appearance().tintColor = UIColor.white
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

}