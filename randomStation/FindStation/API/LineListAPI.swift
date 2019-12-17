//
//  LineListAPI.swift
//  randomStation
//
//  Created by Yuki Homma on 2019/05/24.
//  Copyright © 2019 Yuki Homma(Personal Team). All rights reserved.
//

final class ListAPI {
    struct SearchLineList: ListRequest {
        let keyword: String
        
        typealias Response = LineList
        
        var path: String {
            return "/p/" + keyword + ".json"
        }
        
        var method: HTTPMethod {
            return .get
        }
    }
    
    struct SearchStationList: ListRequest {
        let keyword: String
        
        typealias Response = StationList
        
        var path: String {
            return "/l/" + keyword + ".json"
        }
        
        var method: HTTPMethod {
            return .get
        }
    }
}
