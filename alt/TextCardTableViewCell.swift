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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    //カードの内容を書き込む
    func setCard(){
    }
    
}
