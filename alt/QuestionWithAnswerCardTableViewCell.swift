//
//  QuestionCardTableViewCell.swift
//  alt
//
//  Created by 岡田航汰 on 2017/08/05.
//  Copyright © 2017年 Kota Okada. All rights reserved.
//

import UIKit

class QuestionWithAnswerCardTableViewCell: UITableViewCell {

    @IBOutlet weak var questionWithAnswerContainerView: UIView!
    @IBOutlet weak var answerTextLabel: UILabel!
    @IBOutlet weak var questionTextLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setQuestionWithAnswerCell(question:String, answer:String){
        self.backgroundColor = UIColor.clear

        self.questionWithAnswerContainerView.backgroundColor = UIColor.white
        self.questionWithAnswerContainerView.addCardShadow()
        
        self.questionWithAnswerContainerView.viewWithTag(1)?.addBorderBottom(color: "EBEBEB", margin: 20)
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.questionWithAnswerContainerView.layer.masksToBounds = false

        
        questionTextLabel.text = question
        answerTextLabel.text = answer
        
    }
    
}
