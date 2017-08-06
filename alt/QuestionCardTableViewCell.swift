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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setQuestionCell(question:String){
        self.backgroundColor = UIColor.clear
        
        self.questionContainerView.backgroundColor = UIColor.white
        self.questionContainerView.addCardShadow()
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.questionContainerView.layer.masksToBounds = false
        
        questionTextLabel.text = question
    }
    
}
