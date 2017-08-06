//
//  UIView+makeOptionsButton().swift
//  alt
//
//  Created by 岡田航汰 on 2017/08/06.
//  Copyright © 2017年 Kota Okada. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    func makeOptionsButton(options:Array<String>, count:Int){
        let contenaierHeight = 40+(35*count)+(10*(count-1))
        self.heightAnchor.constraint(equalToConstant: CGFloat(contenaierHeight)).isActive = true

        
        let optionButton1 = UIView(frame:CGRect(x:0,y:0,width:100,height:100))
        optionButton1.translatesAutoresizingMaskIntoConstraints = false
        
        let optionLabel1 = UILabel()
        optionLabel1.translatesAutoresizingMaskIntoConstraints = false
        
        let optionButton2 = UIView(frame:CGRect(x:0,y:0,width:100,height:100))
        optionButton2.translatesAutoresizingMaskIntoConstraints = false
        
        let optionLabel2 = UILabel()
        optionLabel2.translatesAutoresizingMaskIntoConstraints = false
        
        let optionButton3 = UIView(frame:CGRect(x:0,y:0,width:100,height:100))
        optionButton3.translatesAutoresizingMaskIntoConstraints = false
        
        let optionLabel3 = UILabel()
        optionLabel3.font = UIFont.systemFont(ofSize: 15)
        optionLabel3.translatesAutoresizingMaskIntoConstraints = false
        
        let optionButton4 = UIView(frame:CGRect(x:0,y:0,width:100,height:100))
        optionButton4.translatesAutoresizingMaskIntoConstraints = false
        
        let optionLabel4 = UILabel()
        optionLabel4.translatesAutoresizingMaskIntoConstraints = false
        
        let optionButton5 = UIView(frame:CGRect(x:0,y:0,width:100,height:100))
        optionButton5.translatesAutoresizingMaskIntoConstraints = false
        
        let optionLabel5 = UILabel()
        optionLabel5.translatesAutoresizingMaskIntoConstraints = false
        

        var optionButton:UIView
        var optionLabel:UILabel
        var lastoptionButton:UIView = UIView()
        
        for i in 0 ..< count {
            switch i {
            case 0:
                optionButton = optionButton1
                optionLabel = optionLabel1
            case 1:
                optionButton = optionButton2
                optionLabel = optionLabel2
                lastoptionButton = optionButton1
            case 2:
                optionButton = optionButton3
                optionLabel = optionLabel3
                lastoptionButton = optionButton2
            case 3:
                optionButton = optionButton4
                optionLabel = optionLabel4
                lastoptionButton = optionButton1
            case 4:
                optionButton = optionButton5
                optionLabel = optionLabel5
                lastoptionButton = optionButton1
            default:
                optionButton = optionButton1
                optionLabel = optionLabel1
                lastoptionButton = optionButton1
            }
            
            optionButton.backgroundColor = UIColor.white
            optionButton.layer.borderColor = UIColor.colorFromRGB(rgb: "13A7A1", alpha: 1.0).cgColor
            optionButton.layer.borderWidth = 1.0
            optionLabel.font = UIFont.systemFont(ofSize: 15)
            optionLabel.textColor = UIColor.colorFromRGB(rgb: "13A7A1", alpha: 1.0)


            
            optionLabel.text = options[i]
            optionButton.addSubview(optionLabel)
            optionLabel.leadingAnchor.constraint(equalTo: optionButton.leadingAnchor, constant: 15.0).isActive = true
            optionLabel.topAnchor.constraint(equalTo: optionButton.topAnchor, constant: 10.0) .isActive = true
            optionButton.bottomAnchor.constraint(equalTo: optionLabel.bottomAnchor, constant: 10.0) .isActive = true
            
            self.addSubview(optionButton)
            if i == 0{
                optionButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 15.0).isActive = true
            } else {
                optionButton.topAnchor.constraint(equalTo: lastoptionButton.bottomAnchor, constant: 10.0).isActive = true
            }
            optionButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0).isActive = true
            optionButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width-55.0).isActive = true
            self.trailingAnchor.constraint(equalTo: optionButton.trailingAnchor, constant: 15.0).isActive = true
        }
    }
}
