//
//  Line.swift
//  randomStation
//
//  Created by Yuki Homma on 2019/05/24.
//  Copyright © 2019 Yuki Homma(Personal Team). All rights reserved.
//

struct LineList: Decodable {
    let lines: [Line]
    
    enum CodingKeys: String, CodingKey {
        case lines = "line"
    }
}
