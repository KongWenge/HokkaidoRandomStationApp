//
//  LineListClient.swift
//  randomStation
//
//  Created by Yuki Homma on 2019/05/24.
//  Copyright © 2019 Yuki Homma(Personal Team). All rights reserved.
//

import Foundation

class ListClient {
    private let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        return session
    }()
    
    func send<Request: ListRequest> (
        request: Request,
        completion: @escaping (Result<Request.Response, ListError>) -> Void) {
        let urlRequest = request.buildURLRequest()
        let task = session.dataTask(with: urlRequest) {
            data, response, error in
            
            switch(data, response, error) {
            case(_, _, let error?):
                completion(Result(error: .connectionError(error)))
            case(let data?, let response?, _):
                do {
                    let response = try request.response(from: data, urlResponse: response)
                    completion(Result(value: response))
                } catch {
                    completion(Result(error: .responseParseError(error)))
                }
            default:
                fatalError("invalid response combination \(String(describing: data)), \(String(describing: response)), \(String(describing: error))")
            }
        }
        task.resume()
    }
}
