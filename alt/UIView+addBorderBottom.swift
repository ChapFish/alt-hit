//
//  UIView+addBorderBottom.swift
//  alt
//
//  Created by 岡田航汰 on 2017/07/20.
//  Copyright © 2017年 Kota Okada. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    func addBorderBottom(color:String){
        let borderBottom = CALayer()
        borderBottom.frame = CGRect(x: 0, y: self.frame.height-1, width: self.frame.width, height: 1.0)
        borderBottom.backgroundColor = UIColor.colorFromRGB(rgb: color, alpha: 1.0).cgColor
        self.layer.addSublayer(borderBottom)
    }
}
