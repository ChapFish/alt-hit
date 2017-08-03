//
//  TextWithImageCardTableViewCell.swift
//  alt
//
//  Created by 岡田航汰 on 2017/07/18.
//  Copyright © 2017年 Kota Okada. All rights reserved.
//

import UIKit

class TextCardTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var textCardNameLabel: UILabel!
    @IBOutlet weak var textCardContentLabel: UILabel!
    @IBOutlet weak var textCardContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if selected{
            self.textCardContainerView.backgroundColor = UIColor.red
        }else{
            self.textCardContainerView.backgroundColor = UIColor.white
        }
    }
 
    func setTextCard(cardNumber:Int, title:Array<String>, content:Array<String>){
        //カードの内容を書き込む
        self.textCardNameLabel.text = title[cardNumber]
        self.textCardContentLabel.text = content[cardNumber]
        
        //カードの外見を設定
        self.backgroundColor = UIColor.clear
        self.textCardContainerView.backgroundColor = UIColor.white
        self.textCardContainerView.addCardShadow()
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.textCardContainerView.layer.masksToBounds = false
        
        //選択時の色変化を解除
        self.selectionStyle = UITableViewCellSelectionStyle.none
    }
    
}
