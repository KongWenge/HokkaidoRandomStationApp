//
//  LineError.swift
//  randomStation
//
//  Created by Yuki Homma on 2019/05/24.
//  Copyright © 2019 Yuki Homma(Personal Team). All rights reserved.
//

enum ListError: Error {
    // 通信に失敗
    case connectionError(Error)
    
    // レスポンスの解釈に失敗
    case responseParseError(Error)
}
