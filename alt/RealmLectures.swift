//
//  RealmLectures.swift
//  alt
//
//  Created by 岡田航汰 on 2017/08/03.
//  Copyright © 2017年 Kota Okada. All rights reserved.
//

import Foundation
import RealmSwift

class RealmLectures:Object{
    
    dynamic var id = Int()
    dynamic var name = String()
    dynamic var teacher = String()
    dynamic var week = Int()
    dynamic var time = Int()
    dynamic var room = String()
    dynamic var department = String()
    dynamic var cancelFlag = Bool()

}
