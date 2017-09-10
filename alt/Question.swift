//
//  Question.swift
//  alt
//
//  Created by 岡田航汰 on 2017/09/07.
//  Copyright © 2017年 Kota Okada. All rights reserved.
//

import Foundation

struct Question {
    var id:Int = 0
    var questionStatus:Int = 0
    var text:String = ""
    var answers:[String] = []
    var optionCount:Int = 0
    var options:[String] = []
    var optionValues:[Int] = []
    var userAnsweredFlag:Bool = false
    
    mutating func resetQuestion(){
        self.id = 0
        self.questionStatus = 0
        self.text = ""
        self.answers = []
        self.optionCount = 0
        self.options = []
        self.optionValues = []
        self.userAnsweredFlag = false
    
    }
}
