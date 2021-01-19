//
//  ApiServiceProtocols.swift
//  app-image-loading
//
//  Created by maxim mironov on 17.01.2021.
//  Copyright © 2021 maxim mironov. All rights reserved.
//

import Foundation

protocol Api{
    func callAPI(request: URLRequest, completion: @escaping (_ responce: RequestEnum<Data?>) ->())
}
enum RequestEnum<T>{
    case success(data:T?)
    case error(data:T?, errorMessage:RequestError)
}

enum RequestError {
    case cancel
    case any
    case noInternet
    case authentifications
    case sessionError(error: Error)
    case serverError(error: NSError)
    case noData
    
    func noData() -> Bool {
        switch self {
        case .noData:
            return true
        default:
            return false
        }
    }
}
