//
//  LectureCardTableViewCell.swift
//  alt
//
//  Created by 岡田航汰 on 2017/07/16.
//  Copyright © 2017年 Kota Okada. All rights reserved.
//

import UIKit

class LectureCardTableViewCell: UITableViewCell {

    @IBOutlet weak var LectureContenairView: UIView!
    @IBOutlet weak var FirstLectureNameLabel: UILabel!
    @IBOutlet weak var SecondLectureNameLabel: UILabel!
    @IBOutlet weak var ThirdLectureNameLabel: UILabel!
    @IBOutlet weak var FourthLectureNameLabel: UILabel!
    @IBOutlet weak var FifthLectureNameLabel: UILabel!
    @IBOutlet weak var FirstLectureRoomLabel: UILabel!
    @IBOutlet weak var SecondLectureRoomLabel: UILabel!
    @IBOutlet weak var ThirdLectureRoomLable: UILabel!
    @IBOutlet weak var FourthLectureRoomLabel: UILabel!
    @IBOutlet weak var FifthLectureRoomLabel: UILabel!
    
    override func awakeFromNib() {
                super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    func setLectureCard(lectureName:Array<String>, lectureRoom:Array<String>, lectureStatus:Array<String>, lectureFlag:Array<Bool>){
    //カードのコンテンツを入力（入力内容はSetLectureCardItem.swiftで規定）
        LectureContenairView.setLectureIndicatorColor(lectureStatus: lectureStatus)
        FirstLectureNameLabel.setLectureName(lectureName: lectureName, lectureFlag: lectureFlag, lectureNameCount: 1)
        SecondLectureNameLabel.setLectureName(lectureName: lectureName, lectureFlag: lectureFlag, lectureNameCount: 2)
        ThirdLectureNameLabel.setLectureName(lectureName: lectureName, lectureFlag: lectureFlag, lectureNameCount: 3)
        FourthLectureNameLabel.setLectureName(lectureName: lectureName, lectureFlag: lectureFlag, lectureNameCount: 4)
        FifthLectureNameLabel.setLectureName(lectureName: lectureName, lectureFlag: lectureFlag, lectureNameCount: 5)
        FirstLectureRoomLabel.setLectureRoom(lectureRoom: lectureRoom, lectureFlag: lectureFlag, lectureRoomCount: 1)
        SecondLectureRoomLabel.setLectureRoom(lectureRoom: lectureRoom, lectureFlag: lectureFlag, lectureRoomCount: 2)
        ThirdLectureRoomLable.setLectureRoom(lectureRoom: lectureRoom, lectureFlag: lectureFlag, lectureRoomCount: 3)
        FourthLectureRoomLabel.setLectureRoom(lectureRoom: lectureRoom, lectureFlag: lectureFlag, lectureRoomCount: 4)
        FifthLectureRoomLabel.setLectureRoom(lectureRoom: lectureRoom, lectureFlag: lectureFlag, lectureRoomCount: 5)
    //カードの見た目を設定
        self.backgroundColor = UIColor.clear
        self.LectureContenairView.backgroundColor = UIColor.white
        self.LectureContenairView.layer.shadowColor = UIColor.black.cgColor /* 影の色 */
        self.LectureContenairView.layer.shadowOffset = CGSize(width:2, height:2) /* 影の大きさ */
        self.LectureContenairView.layer.shadowOpacity = 0.3 /* 透明度 */
        self.LectureContenairView.layer.shadowRadius = 1 /* 影の距離 */
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.LectureContenairView.layer.masksToBounds = false
        
    }

}
