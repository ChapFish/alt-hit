//
//  WeatherCardTableViewCell.swift
//  alt
//
//  Created by 岡田航汰 on 2017/07/25.
//  Copyright © 2017年 Kota Okada. All rights reserved.
//

import UIKit

class WeatherCardTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var highestTempLabel: UILabel!
    @IBOutlet weak var lowestTempLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var rainyPercentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setWeatherCell(){
        
    }
    
}
