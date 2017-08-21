//
//  QuestionTableViewCell.swift
//  alt
//
//  Created by 岡田航汰 on 2017/08/06.
//  Copyright © 2017年 Kota Okada. All rights reserved.
//

import UIKit

class QuestionCardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var questionTextLabel: UILabel!
    @IBOutlet weak var questionContainerView: UIView!
    @IBOutlet weak var answerIndicator: UIView!
    @IBOutlet weak var answerMsgLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if selected {
            questionContainerView.alpha = 0.5
        } else {
            questionContainerView.alpha = 1.0
        }
    }
    
    func setQuestionCell(question:String, unanswered:Bool = true, msg:Bool = true){
        self.backgroundColor = UIColor.clear
        
        self.questionContainerView.backgroundColor = UIColor.white
        self.questionContainerView.addCardShadow()
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.questionContainerView.layer.masksToBounds = false
        
        questionTextLabel.text = question
        

        //これ三項演算子っていうらしいよ。
        answerMsgLabel.text = msg ? "回答する" : " "
        answerIndicator.backgroundColor = UIColor.colorFromRGB(rgb: unanswered ? "FFAA9F" : "94EFBC", alpha: 1.0)
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
    }
    
}
