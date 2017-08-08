//
//  SurveyQuestionCardTableViewCell.swift
//  alt
//
//  Created by 岡田航汰 on 2017/08/06.
//  Copyright © 2017年 Kota Okada. All rights reserved.
//

import UIKit

class SurveyQuestionCardTableViewCell: UITableViewCell {
    
    var deligate: TapOptionDeligate?
    
    @IBOutlet weak var surveyContainerView: UIView!
    @IBOutlet weak var questionTextLabel: UILabel!
    @IBOutlet weak var optionsContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setSurveyQuestionCell(question: String, options:Array<String>){
        self.backgroundColor = UIColor.clear
        self.surveyContainerView.backgroundColor = UIColor.white
        self.surveyContainerView.addCardShadow()
        
        self.surveyContainerView.viewWithTag(1)?.addBorderBottom(color: "EBEBEB", margin: 20)
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.surveyContainerView.layer.masksToBounds = false
        
        questionTextLabel.text = question
        self.optionsContainerView.makeOptionsButton(options: options, count: options.count)
        
        for i in 1...5 {
            if let _ = self.optionsContainerView.viewWithTag(i) {
                let optionTap = UITapGestureRecognizer(target:self, action: #selector(self.tapOption(sender: )))
                optionTap.numberOfTapsRequired = 1
                self.optionsContainerView.viewWithTag(i)?.addGestureRecognizer(optionTap)
            }else{
                print("viewwithtag(\(i)) is nil")
            }
        }
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
    }
    
    //選択肢タップ時のアニメーションの設定。
    func tapOption(sender: UITapGestureRecognizer){
        UIView.animate(withDuration: 0.3, animations: {
            sender.view?.alpha = 0.5
        }) {_ in
            sender.view?.alpha = 1.0
        }
        self.deligate?.getOptionID(optionID: (sender.view?.tag)!)
    }
    
}
