//
//  URLSessionApiSrevices.swift
//  app-image-loading
//
//  Created by maxim mironov on 17.01.2021.
//  Copyright © 2021 maxim mironov. All rights reserved.
//

import Foundation
class URLSessionApiSrevices: Api {
    var task: URLSessionTask?
    var error : String?

    private var urlSession: URLSession

    fileprivate let cache = URLCache.shared
    fileprivate let cacheInterval:Double = 7.0

    public init(config:URLSessionConfiguration = URLSessionConfiguration.default) {
       self.urlSession = URLSession(configuration: config)
    }
    func callAPI(request: URLRequest, completion: @escaping (RequestEnum<Data?>) -> ()) {
        if let dataFromCache = self.getDataFromCache(request: request){
            completion(RequestEnum.success(data: dataFromCache))
            return
        }
        if Utils.shared.isInternetAvailable {
            defer { self.task = nil }
            completion(RequestEnum.error( data: nil, errorMessage: RequestError.noInternet))
        }
         self.task = self.urlSession.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(RequestEnum.error(data: nil, errorMessage: RequestError.sessionError(error: error)))
            }

            else if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                if (200...399).contains(statusCode) {
                    guard let data = data else {
                        completion(RequestEnum.error(data: nil, errorMessage: .noData))
                        return
                    }
                    let cachedData = CachedURLResponse(response: httpResponse, data: data)
                    self.setDataToCache(cachedData: cachedData, for: request)
                    completion(RequestEnum.success(data: data))
                }
                else{
                    let taskError = NSError(domain: String(describing:type(of: self)), code: statusCode, userInfo:  nil)
                    completion(RequestEnum.error(data: nil, errorMessage: RequestError.sessionError(error: taskError)))
                }
            }
            self.task?.cancel()
        }
        self.task?.resume()
    }
    
    
    fileprivate func getDataFromCache(request: URLRequest) -> Data?{
        return self.cache.cachedResponse(for: request)?.data
    }
    
    fileprivate func setDataToCache(cachedData:CachedURLResponse, for request: URLRequest){
        self.cache.storeCachedResponse(cachedData, for: request)
    }
   
}
