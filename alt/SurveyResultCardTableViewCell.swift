//
//  SurveyResultTableViewCell.swift
//  alt
//
//  Created by 岡田航汰 on 2017/08/08.
//  Copyright © 2017年 Kota Okada. All rights reserved.
//

import UIKit

class SurveyResultCardTableViewCell: UITableViewCell {

    @IBOutlet weak var questionTextLabel: UILabel!
    @IBOutlet weak var resultsContainerView: UIView!
    @IBOutlet weak var surveyContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setSurveyResultCell(question: String, options:Array<String>, results:Array<Int>, count:Int){
        self.backgroundColor = UIColor.clear
        self.surveyContainerView.backgroundColor = UIColor.white
        self.surveyContainerView.addCardShadow()
        
        self.surveyContainerView.viewWithTag(1)?.addBorderBottom(color: "EBEBEB", margin: 20)
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.surveyContainerView.layer.masksToBounds = false
        
        questionTextLabel.text = question
        self.resultsContainerView.makeResultGraph(options: options, results: results, count: count)
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
    }
}
