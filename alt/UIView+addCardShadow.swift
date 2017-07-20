//
//  View+setShadow.swift
//  alt
//
//  Created by 岡田航汰 on 2017/07/20.
//  Copyright © 2017年 Kota Okada. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    func addCardShadow(){
        self.layer.shadowColor = UIColor.black.cgColor /* 影の色 */
        self.layer.shadowOffset = CGSize(width:2, height:2) /* 影の大きさ */
        self.layer.shadowOpacity = 0.3 /* 透明度 */
        self.layer.shadowRadius = 1 /* 影の距離 */
    }
}

/*　カードのViewに適用したあと、セル全体に
 
self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
self.layer.shouldRasterize = true
self.layer.rasterizationScale = UIScreen.main.scale
self.ビューの名前.layer.masksToBounds = false
 
をつけること　*/
