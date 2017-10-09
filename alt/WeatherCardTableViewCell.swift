//
//  WeatherCardTableViewCell.swift
//  alt
//
//  Created by 岡田航汰 on 2017/07/25.
//  Copyright © 2017年 Kota Okada. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WeatherCardTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var highestTempLabel: UILabel!
    @IBOutlet weak var lowestTempLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var rainyPercentLabel: UILabel!
    @IBOutlet weak var weatherCardContainerView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setWeatherCell(todayWeatherData:Array<String>){
        highestTempLabel.text = todayWeatherData[0]
        lowestTempLabel.text = " / \(todayWeatherData[1])"
        weatherLabel.text = todayWeatherData[2]
        rainyPercentLabel.text = "湿度：\(todayWeatherData[3])%"
        weatherIconImageView.image = UIImage(named:"altoLogo2AppIcon.jpg")
        
        //カードの外見を設定
        self.backgroundColor = UIColor.clear
        self.weatherCardContainerView.backgroundColor = UIColor.white
        self.weatherCardContainerView.addCardShadow()
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.weatherCardContainerView.layer.masksToBounds = false
        
        //選択時の色変化を解除
        self.selectionStyle = UITableViewCellSelectionStyle.none
        
    }
}
