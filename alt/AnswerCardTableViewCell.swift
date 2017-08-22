//
//  AnswerCardTableViewCell.swift
//  alt
//
//  Created by 岡田航汰 on 2017/08/21.
//  Copyright © 2017年 Kota Okada. All rights reserved.
//

import UIKit

class AnswerCardTableViewCell: UITableViewCell {

    @IBOutlet weak var answerTextLabel: UILabel!
    @IBOutlet weak var answerContainerView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setAnswerCell(answer:String){
        self.backgroundColor = UIColor.clear
        
        self.answerContainerView.backgroundColor = UIColor.white
        self.answerContainerView.addCardShadow()
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.answerContainerView.layer.masksToBounds = false
        
        answerTextLabel.text = answer
    }
    
}
