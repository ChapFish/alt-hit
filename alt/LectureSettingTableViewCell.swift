//
//  LectureSettingTableViewCell.swift
//  alt
//
//  Created by 岡田航汰 on 2017/07/27.
//  Copyright © 2017年 Kota Okada. All rights reserved.
//

import UIKit

class LectureSettingTableViewCell: UITableViewCell {
    @IBOutlet weak var lectureNameLabel: UILabel!
    @IBOutlet weak var lectureInfoLabel: UILabel!
    @IBOutlet weak var lectureSettingContenairView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if selected {
            lectureSettingContenairView.alpha = 0.8
        }else{
            lectureSettingContenairView.alpha = 1.0
        }
    }
    
    func setLectureSettingCell(aDayLecture: [[String]], period: Int){
        //内容を書き込む
        //periodはindexPath.rowからそのセルの表す時限を示し、0-4の整数値となる。
        if aDayLecture[period] == [] {
            lectureNameLabel.text = "\(period+1)限の授業を探す"
            lectureNameLabel.textColor = UIColor.colorFromRGB(rgb: "13A7A1", alpha: 0.75)
            lectureInfoLabel.text = ""
            lectureInfoLabel.textColor = UIColor.colorFromRGB(rgb: "13A7A1", alpha: 0.75)
            self.lectureSettingContenairView.backgroundColor = UIColor.colorFromRGB(rgb: "FFFFFF", alpha: 0.75)

        }else{
            lectureNameLabel.text = aDayLecture[period][0]
            lectureNameLabel.textColor = UIColor.colorFromRGB(rgb: "13A7A1", alpha: 1.0)
            lectureInfoLabel.text = aDayLecture[period][5]
            lectureInfoLabel.textColor = UIColor.colorFromRGB(rgb: "13A7A1", alpha: 1.0)
            self.lectureSettingContenairView.backgroundColor = UIColor.colorFromRGB(rgb: "FFFFFF", alpha: 1.0)
        }
        
        //外見を指定
        self.backgroundColor = UIColor.clear
        self.lectureSettingContenairView.addCardShadow()
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.lectureSettingContenairView.layer.masksToBounds = false
        
        //選択時の色変化を解除
        self.selectionStyle = UITableViewCellSelectionStyle.none
    }
    
}
