//
//  LineListRequest.swift
//  randomStation
//
//  Created by Yuki Homma on 2019/05/24.
//  Copyright © 2019 Yuki Homma(Personal Team). All rights reserved.
//

import Foundation

protocol ListRequest {
    associatedtype Response: Decodable
    
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
}

extension ListRequest {
    var baseURL: URL {
        return URL(string: "https://www.ekidata.jp/api")!
    }
    
    func buildURLRequest() -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.url = url
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
    
    func response(from data: Data, urlResponse: URLResponse) throws -> Response {
        let decoder = JSONDecoder()
        
        var str = String(data: data, encoding: String.Encoding.utf8)!
        if let range = str.range(of: "\nif(typeof(xml)==\'undefined\') xml = {};\nxml.data = ") {
            str.replaceSubrange(range, with: "")
        }
        if let range = str.range(of: "if(typeof(xml.onload)=='function') xml.onload(xml.data);") {
            str.replaceSubrange(range, with: "")
        }
        let arrangedData = str.data(using: .utf8)!
        
        return try decoder.decode(Response.self, from: arrangedData)
    }
}
