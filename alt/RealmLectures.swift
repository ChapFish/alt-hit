//
//  RealmLectures.swift
//  alt
//
//  Created by 岡田航汰 on 2017/08/03.
//  Copyright © 2017年 Kota Okada. All rights reserved.
//

import Foundation
import RealmSwift

class RealmLecture:Object{
    
    dynamic var id = Int()
    dynamic var name = String()
    dynamic var teacher = String()
    dynamic var week = Int()
    dynamic var time = Int()
    dynamic var room = String()
    dynamic var department = Int()
    dynamic var season = Int()
    dynamic var cancelFlag = Bool()
    
}
