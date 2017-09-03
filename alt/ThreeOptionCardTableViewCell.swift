//
//  ThreeOptionCardTableViewCell.swift
//  alt
//
//  Created by 岡田航汰 on 2017/08/29.
//  Copyright © 2017年 Kota Okada. All rights reserved.
//

import UIKit

class ThreeOptionCardTableViewCell: UITableViewCell {
    
    var deligate: TapOptionDeligate?
    var questionID: Int = 0
    var indexAtTable: Int = 0

    @IBOutlet weak var surveyContainerView: UIView!
    @IBOutlet weak var answerIndicator: UIView!
    @IBOutlet weak var questionTextLabel: UILabel!
    @IBOutlet weak var questionContainerView: UIView!
    @IBOutlet weak var aOptionLabel: UILabel!
    @IBOutlet weak var aOptionValue: UILabel!
    @IBOutlet weak var bOptionLabel: UILabel!
    @IBOutlet weak var bOptionValue: UILabel!
    @IBOutlet weak var cOptionLabel: UILabel!
    @IBOutlet weak var cOptionValue: UILabel!
    @IBOutlet weak var optionsContainerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

        // Configure the view for the selected state
    }
    
    func setThreeOptionCell(question:String, options:Array<String>, results:Array<Int>, userAnswered:Bool){
        
        self.backgroundColor = UIColor.clear
        self.surveyContainerView.backgroundColor = UIColor.white
        self.questionContainerView.addBorderBottom(color: "EBEBEB", margin: 25)
        
        self.surveyContainerView.addCardShadow()
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.surveyContainerView.layer.masksToBounds = false
        
        questionTextLabel.text = question
        
        let indexOfMaxValue = results.index(of: results.max()!)
        let resultSum = results.reduce(0,{$0+$1})
        
        questionTextLabel.text = question
        questionContainerView.addBorderBottom(color: "EBEBEB", margin: 25)
        
        aOptionLabel.text = options[0]
        bOptionLabel.text = options[1]
        cOptionLabel.text = options[2]
        aOptionValue.text = "\(resultSum == 0 ? 0 : Int(round(Double(results[0])/Double(resultSum)*100)))%"
        bOptionValue.text = "\(resultSum == 0 ? 0 : Int(round(Double(results[1])/Double(resultSum)*100)))%"
        cOptionValue.text = "\(resultSum == 0 ? 0 : Int(round(Double(results[2])/Double(resultSum)*100)))%"
        
        if userAnswered {
            for i in 0...2{
                self.optionsContainerView.viewWithTag(i+1)?.layer.borderColor = UIColor.clear.cgColor
                self.answerIndicator.backgroundColor = UIColor.colorFromRGB(rgb: "94EFBC", alpha: 1.0)
                
                let graph = CALayer()
                let graphWidth = (UIScreen.main.bounds.size.width-60.0) * (CGFloat(results[i])/CGFloat(resultSum))
                graph.frame = CGRect(x:0, y:0, width: graphWidth, height:35)
                if i == indexOfMaxValue{
                    graph.backgroundColor = UIColor.colorFromRGB(rgb: "94EFBC", alpha: 1.0).cgColor
                }else{
                    graph.backgroundColor = UIColor.colorFromRGB(rgb: "EBEBEB", alpha: 1.0).cgColor
                }
                self.optionsContainerView.viewWithTag(i+1)?.layer.insertSublayer(graph, at: 0)
            }
            
            aOptionLabel.textColor = UIColor.colorFromRGB(rgb: (indexOfMaxValue == 0 ? "393939":"13A7A1"), alpha: 1.0)
            aOptionValue.textColor = UIColor.colorFromRGB(rgb: (indexOfMaxValue == 0 ? "393939":"13A7A1"), alpha: 1.0)
            bOptionLabel.textColor = UIColor.colorFromRGB(rgb: (indexOfMaxValue == 1 ? "393939":"13A7A1"), alpha: 1.0)
            bOptionValue.textColor = UIColor.colorFromRGB(rgb: (indexOfMaxValue == 1 ? "393939":"13A7A1"), alpha: 1.0)
            cOptionLabel.textColor = UIColor.colorFromRGB(rgb: (indexOfMaxValue == 2 ? "393939":"13A7A1"), alpha: 1.0)
            cOptionValue.textColor = UIColor.colorFromRGB(rgb: (indexOfMaxValue == 2 ? "393939":"13A7A1"), alpha: 1.0)
            
        }else{
            self.answerIndicator.backgroundColor = UIColor.colorFromRGB(rgb: "FFAA9F", alpha: 1.0)
            for i in 0...2{
                self.optionsContainerView.viewWithTag(i+1)?.layer.borderWidth = 1.0
                self.optionsContainerView.viewWithTag(i+1)?.layer.borderColor = UIColor.colorFromRGB(rgb: "13A7A1", alpha: 1.0).cgColor
                let optionTap = UITapGestureRecognizer(target:self, action: #selector(self.tapOption(sender: )))
                optionTap.numberOfTapsRequired = 1
                self.optionsContainerView.viewWithTag(i+1)?.addGestureRecognizer(optionTap)
            }
            aOptionLabel.textColor = UIColor.colorFromRGB(rgb: "13A7A1", alpha: 1.0)
            bOptionLabel.textColor = UIColor.colorFromRGB(rgb: "13A7A1", alpha: 1.0)
            cOptionLabel.textColor = UIColor.colorFromRGB(rgb: "13A7A1", alpha: 1.0)
            aOptionValue.isHidden = true
            bOptionValue.isHidden = true
            cOptionValue.isHidden = true
        }
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
    }
    
    func tapOption(sender: UITapGestureRecognizer){
        UIView.animate(withDuration: 0.2, animations: {
            sender.view?.alpha = 0.5
        })
        self.deligate?.getOptionID(optionIndex: (sender.view?.tag)!, questionID: questionID, indexAtTable: indexAtTable)
    }
    
}
