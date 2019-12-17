//
//  Line.swift
//  randomStation
//
//  Created by Yuki Homma on 2019/05/24.
//  Copyright © 2019 Yuki Homma(Personal Team). All rights reserved.
//

struct Line: Decodable {
    let code: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case code = "line_cd"
        case name = "line_name"
    }
}
