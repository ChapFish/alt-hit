//
//  SetLectureCardItem.swift
//  alt
//
//  Created by 岡田航汰 on 2017/07/17.
//  Copyright © 2017年 Kota Okada. All rights reserved.
//

import Foundation
import UIKit

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
    func setLectureIndicatorColor(lectureStatus:Array<String>, lectureFlag:Array<Bool>){
        //ほんとは学部登録で設定するけどとりあえずここで定義しておく。
        UserDefaults.standard.set("社会学部", forKey: "学部")
        for i in 0...4{
            if lectureStatus[i] == UserDefaults.standard.string(forKey: "学部"){
                self.viewWithTag(i+1)?.backgroundColor = UIColor.colorFromRGB(rgb: "27CC70", alpha: 1.0)
            }else if lectureFlag[i] || lectureStatus[i] == ""{
                self.viewWithTag(i+1)?.backgroundColor = UIColor.colorFromRGB(rgb: "CCCCCC", alpha: 1.0)
            }else{
                self.viewWithTag(i+1)?.backgroundColor = UIColor.colorFromRGB(rgb: "068DC4", alpha: 1.0)
            }
        }
    }
}

