//
//  Station.swift
//  randomStation
//
//  Created by Yuki Homma on 2019/05/29.
//  Copyright © 2019 Yuki Homma(Personal Team). All rights reserved.
//

import Foundation

struct Station: Decodable {
    var code: Int
    var group: Int
    var name: String
    var lon: Double
    var lat: Double
    
    private enum CodingKeys: String, CodingKey {
        case code = "station_cd"
        case group = "station_g_cd"
        case name = "station_name"
        case lon
        case lat
    }
}
