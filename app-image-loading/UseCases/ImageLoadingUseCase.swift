//
//  ImageLoadingUseCase.swift
//  app-image-loading
//
//  Created by maxim mironov on 19.01.2021.
//  Copyright © 2021 maxim mironov. All rights reserved.
//

import Foundation
class ImageLoadingUseCase{
    var service: Api!
    init() {
        self.service = URLSessionApiSrevices()
    }
    func getImage(url:String, completion: @escaping (Data?) -> ()){
         guard let url = URL(string: url) else {return  completion(nil);}
         DispatchQueue.global(qos: .background).async {
            self.service.callAPI(request: URLRequest(url: url)) { (responce) in
                switch responce{
                case .success(data: let data):
                    completion(data ?? nil);
                case .error(data: _, errorMessage: _):
                    completion(nil);
                }
            }
        }
    }
    
}
