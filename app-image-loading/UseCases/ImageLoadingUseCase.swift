//
//  ImageLoadingUseCase.swift
//  app-image-loading
//
//  Created by maxim mironov on 19.01.2021.
//  Copyright © 2021 maxim mironov. All rights reserved.
//

import Foundation
import UIKit

class ImageLoadingUseCase{
    
    var service: Api!
    var uuid: UUID!
    
    private let cache = NSCache<NSString, UIImage>()
    
    init() {
        self.service = URLSessionApiSrevices()
    }
    
    func getImage(url:String, completion: @escaping (UIImage?, String?) -> ()) {
        guard let url = URL(string: url) else {return}
        if let image = self.cache.object(forKey: url.absoluteString as NSString){
            completion(image, url.absoluteString);
        }
        self.uuid = UUID()
        DispatchQueue.global(qos: .background).async {
            self.service.callAPI(request: URLRequest(url: url)) { (responce) in
                switch responce{
                case .success(data: let data):
                    guard let data = data else{
                        completion(nil, url.absoluteString)
                        return
                    }
                    if let image = UIImage(data: data!){
                        self.cache.setObject(image, forKey: url.absoluteString as NSString)
                        completion(image, url.absoluteString);
                    }
                case .error(data: _, errorMessage: let error):
                    if error.noData(){
                        completion(UIImage(named: ImagesConstats.loadingErrorImage.rawValue), nil);
                    }
                }
            }
        }
    }
    
}
