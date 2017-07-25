//
//  getWeatherData.swift
//  alt
//
//  Created by 岡田航汰 on 2017/07/25.
//  Copyright © 2017年 Kota Okada. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class GetWeatherData {
    func getTodayWeatherData() -> Array<String> {
        var todayWeatherData:[String] = []
        Alamofire.request("http://api.openweathermap.org/data/2.5/weather", parameters: ["q":"Kunitachi", "appid":"8754aa3f67b1bfd63319a928da5cc860"]).responseJSON{ response in
            guard let object = response.result.value else{
                return
            }
            print(object)
            let json = JSON(object)
            todayWeatherData.append(json["main"]["temp_max"].stringValue)
            todayWeatherData.append(json["main"]["temp_min"].stringValue)
            todayWeatherData.append(json["weather"]["main"].stringValue)
            todayWeatherData.append(json["main"]["humidity"].stringValue)
            print(todayWeatherData)
        }
        return todayWeatherData
    }
}
