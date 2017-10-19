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
        
        tabBar.items![0].title = "Home"
        tabBar.items![1].title = "Voice"
        tabBar.items![0].image = UIImage(named: "home_icon_50px_50_@2x.png")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        tabBar.items![1].image = UIImage(named: "voice_icon_50px_50@2x.png")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        tabBar.items![0].selectedImage = UIImage(named: "home_icon_50px_100_@2x.png")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        tabBar.items![1].selectedImage = UIImage(named: "voice_icon_50px_100@2x.png")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)

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
