//
//  UIView+makeOptionsButton().swift
//  alt
//
//  Created by 岡田航汰 on 2017/08/06.
//  Copyright © 2017年 Kota Okada. All rights reserved.
//

import Foundation
import UIKit

//これはうまくいかなかったから使ってない。
extension UIView{
    //選択肢のボタンを表示する。
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
                lastoptionButton = optionButton3
            case 4:
                optionButton = optionButton5
                optionLabel = optionLabel5
                lastoptionButton = optionButton4
            default:
                optionButton = optionButton1
                optionLabel = optionLabel1
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
            optionButton.tag = i + 1
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
    
    
    //結果のグラフを表示する。
    func makeResultGraph(options:Array<String>, results:Array<Int>, count:Int){
        let indexOfMaxValue = results.index(of: results.max()!)
        
        let contenaierHeight = 40+(35*count)+(10*(count-1))
        let resultSum = results.reduce(0,{$0+$1})
        
        self.heightAnchor.constraint(equalToConstant: CGFloat(contenaierHeight)).isActive = true
        
        
        let resultGraph1 = UIView(frame:CGRect(x:0,y:0,width:100,height:100))
        resultGraph1.translatesAutoresizingMaskIntoConstraints = false
        let resultLabel1 = UILabel()
        resultLabel1.translatesAutoresizingMaskIntoConstraints = false
        let resultValue1 = UILabel()
        resultValue1.translatesAutoresizingMaskIntoConstraints = false

        let resultGraph2 = UIView(frame:CGRect(x:0,y:0,width:100,height:100))
        resultGraph2.translatesAutoresizingMaskIntoConstraints = false
        let resultLabel2 = UILabel()
        resultLabel2.translatesAutoresizingMaskIntoConstraints = false
        let resultValue2 = UILabel()
        resultValue2.translatesAutoresizingMaskIntoConstraints = false

        let resultGraph3 = UIView(frame:CGRect(x:0,y:0,width:100,height:100))
        resultGraph3.translatesAutoresizingMaskIntoConstraints = false
        let resultLabel3 = UILabel()
        resultLabel3.translatesAutoresizingMaskIntoConstraints = false
        let resultValue3 = UILabel()
        resultValue3.translatesAutoresizingMaskIntoConstraints = false

        let resultGraph4 = UIView(frame:CGRect(x:0,y:0,width:100,height:100))
        resultGraph4.translatesAutoresizingMaskIntoConstraints = false
        let resultLabel4 = UILabel()
        resultLabel4.translatesAutoresizingMaskIntoConstraints = false
        let resultValue4 = UILabel()
        resultValue4.translatesAutoresizingMaskIntoConstraints = false

        let resultGraph5 = UIView(frame:CGRect(x:0,y:0,width:100,height:100))
        resultGraph5.translatesAutoresizingMaskIntoConstraints = false
        let resultLabel5 = UILabel()
        resultLabel5.translatesAutoresizingMaskIntoConstraints = false
        let resultValue5 = UILabel()
        resultValue5.translatesAutoresizingMaskIntoConstraints = false

        
        
        var resultGraph:UIView
        var resultLabel:UILabel
        var resultValue:UILabel
        var lastResultGraph:UIView = UIView()

        
        for i in 0 ..< count {
            switch i {
            case 0:
                resultGraph = resultGraph1
                resultLabel = resultLabel1
                resultValue = resultValue1
            case 1:
                resultGraph = resultGraph2
                resultLabel = resultLabel2
                resultValue = resultValue2
                lastResultGraph = resultGraph1
            case 2:
                resultGraph = resultGraph3
                resultLabel = resultLabel3
                resultValue = resultValue3
                lastResultGraph = resultGraph2
            case 3:
                resultGraph = resultGraph4
                resultLabel = resultLabel4
                resultValue = resultValue4
                lastResultGraph = resultGraph3
            case 4:
                resultGraph = resultGraph5
                resultLabel = resultLabel5
                resultValue = resultValue5
                lastResultGraph = resultGraph4
            default:
                resultGraph = resultGraph1
                resultLabel = resultLabel1
                resultValue = resultValue1
            }
            
            resultGraph.backgroundColor = UIColor.white
            let graph = CALayer()
            let graphWidth = (UIScreen.main.bounds.size.width-55.0) * (CGFloat(results[i])/CGFloat(resultSum))
            graph.frame = CGRect(x: 0, y: 0, width: graphWidth, height: 36)
            if i == indexOfMaxValue{
                graph.backgroundColor = UIColor.colorFromRGB(rgb: "94EFBC", alpha: 1.0).cgColor
            }else{
                graph.backgroundColor = UIColor.colorFromRGB(rgb: "EBEBEB", alpha: 1.0).cgColor
            }
            resultGraph.layer.addSublayer(graph)
            
            resultLabel.font = UIFont.systemFont(ofSize: 15)
            resultValue.font = UIFont.systemFont(ofSize: 15)
            if i == indexOfMaxValue! {
                resultLabel.textColor = UIColor.colorFromRGB(rgb: "303030", alpha: 1.0)
                resultValue.textColor = UIColor.colorFromRGB(rgb: "303030", alpha: 1.0)
            }else{
                resultLabel.textColor = UIColor.colorFromRGB(rgb: "13A7A1", alpha: 1.0)
                resultValue.textColor = UIColor.colorFromRGB(rgb: "13A7A1", alpha: 1.0)
            }
            
            //選択肢の名前を追加。
            resultLabel.text = options[i]
            resultGraph.addSubview(resultLabel)
            resultLabel.leadingAnchor.constraint(equalTo: resultGraph.leadingAnchor, constant: 15.0).isActive = true
            resultLabel.topAnchor.constraint(equalTo: resultGraph.topAnchor, constant: 10.0) .isActive = true
            resultGraph.bottomAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 10.0) .isActive = true
            //選択肢の投票結果を追加。
            resultValue.text = "\(Int(round(Double(results[i])/Double(resultSum)*100)))%"
            resultGraph.addSubview(resultValue)
            resultValue.topAnchor.constraint(equalTo: resultGraph.topAnchor, constant: 10.0) .isActive = true
            resultGraph.bottomAnchor.constraint(equalTo: resultValue.bottomAnchor, constant: 10.0) .isActive = true
            resultGraph.trailingAnchor.constraint(equalTo: resultValue.trailingAnchor, constant: 10.0).isActive = true

            
            self.addSubview(resultGraph)
            if i == 0{
                resultGraph.topAnchor.constraint(equalTo: self.topAnchor, constant: 15.0).isActive = true
            } else {
                resultGraph.topAnchor.constraint(equalTo: lastResultGraph.bottomAnchor, constant: 10.0).isActive = true
            }
            resultGraph.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0).isActive = true
            resultGraph.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width-55.0).isActive = true
            self.trailingAnchor.constraint(equalTo: resultGraph.trailingAnchor, constant: 15.0).isActive = true
        }
    }
}
