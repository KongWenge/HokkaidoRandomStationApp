//
//  Station.swift
//  randomStation
//
//  Created by Yuki Homma on 2019/05/29.
//  Copyright © 2019 Yuki Homma(Personal Team). All rights reserved.
//

import Foundation

struct StationList: Decodable {
    var code: Int
    var name: String
    var lon: Double
    var lat: Double
    var zoom: Int
    var stations:[Station]
    
    private enum CodingKeys: String, CodingKey {
        case code = "line_cd"
        case name = "line_name"
        case lon = "line_lon"
        case lat = "line_lat"
        case zoom = "line_zoom"
        case stations = "station_l"
    }
}
