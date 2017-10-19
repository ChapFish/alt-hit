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
 
    func setLectureCard(lectureName:Array<String>, lectureRoom:Array<String>, lectureStatus:Array<Int>, lectureFlag:Array<Bool>){
        //カードのコンテンツを入力（入力内容は下の方にextensionで書いてあるよ。）
        LectureContenairView.setLectureIndicatorColor(lectureStatus: lectureStatus, lectureFlag: lectureFlag)
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

        //各行に仕切りの下線をつける
        for i in 0...3{
            self.LectureContenairView.viewWithTag(i+6)?.addBorderBottom(color: "EBEBEB", margin: 60)
        }
        
        //カードの外見を設定
        self.backgroundColor = UIColor.clear
        self.LectureContenairView.backgroundColor = UIColor.white
        self.LectureContenairView.addCardShadow()
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.LectureContenairView.layer.masksToBounds = false
        
        //選択時の色変化を解除
        self.selectionStyle = UITableViewCellSelectionStyle.none
        
    }

}

//メモ：各インジゲーターに上から１〜５、時間割の行に上から６〜10のタグが打ってあるよ。

extension UILabel{
    //休講かどうかを判断のち、授業名を設定
    func setLectureName(lectureName:Array<String>, lectureFlag:Array<Bool>, lectureNameCount:Int){
        self.text = lectureName[lectureNameCount-1]
        if lectureFlag[lectureNameCount-1]{
            self.textColor = UIColor.colorFromRGB(rgb: "FF4B4B", alpha: 1.0)
        }else{
            self.textColor = UIColor.colorFromRGB(rgb: "393939", alpha: 1.0)
        }
    }
    //休講かどうかを判断のち、教室名を設定
    func setLectureRoom(lectureRoom:Array<String>, lectureFlag:Array<Bool>, lectureRoomCount:Int){
        if lectureFlag[lectureRoomCount-1]{
            self.text = "休講"
            self.textColor = UIColor.colorFromRGB(rgb: "FF4B4B", alpha: 1.0)
        }else{
            self.text = lectureRoom[lectureRoomCount-1]
            self.textColor = UIColor.colorFromRGB(rgb: "393939", alpha: 1.0)
        }
    }
}

extension UIView{
    //学部を識別するインジゲーターの色を設定
    func setLectureIndicatorColor(lectureStatus:Array<Int>, lectureFlag:Array<Bool>){
        //ほんとは自分の学部を学部登録で設定するけどとりあえずここで定義しておく。
        for i in 0...4{
            if lectureFlag[i]{
                self.viewWithTag(i+1)?.backgroundColor = UIColor.colorFromRGB(rgb: "FFAA94", alpha: 1.0)
            }else if lectureStatus[i] == 99{
                self.viewWithTag(i+1)?.backgroundColor = UIColor.colorFromRGB(rgb: "CCCCCC", alpha: 1.0)
            }else if lectureStatus[i] == UserDefaults.standard.integer(forKey: "userDepartment"){
                self.viewWithTag(i+1)?.backgroundColor = UIColor.colorFromRGB(rgb: "27CC70", alpha: 1.0)
            }else{
                self.viewWithTag(i+1)?.backgroundColor = UIColor.colorFromRGB(rgb: "068DC4", alpha: 1.0)
            }
        }
    }
}
