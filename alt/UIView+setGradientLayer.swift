//
//  UIView+setGradientLayer.swift
//  alt
//
//  Created by 岡田航汰 on 2017/07/27.
//  Copyright © 2017年 Kota Okada. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    func setGradientLayer(direction:String){
        let rightColor = UIColor.colorFromRGB(rgb: "27CC70", alpha: 1.0).cgColor
        let leftColor = UIColor.colorFromRGB(rgb: "068DC4", alpha: 1.0).cgColor
        let gradientColor:[CGColor] = [rightColor,leftColor]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColor
        gradientLayer.frame = self.bounds
        
        if direction == "horizonal"{
            gradientLayer.startPoint = CGPoint(x: 1, y: 0.5)
            gradientLayer.endPoint = CGPoint(x:0, y: 0.5)
        }else{
            gradientLayer.startPoint = CGPoint(x: 1, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        }
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
