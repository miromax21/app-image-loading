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
    private var uuidMap = [UUID: URLSessionDataTask]()
    init() {
        self.service = URLSessionApiSrevices()
    }
    func getImage(url:String, completion: @escaping (UIImage?) -> ()) -> UUID?{
         guard let url = URL(string: url) else {return nil}
         let uuid = UUID()
         DispatchQueue.global(qos: .background).async {
            let task = self.service.callAPI(request: URLRequest(url: url)) { (responce) in
                switch responce{
                case .success(data: let data):
                    guard let data = data else{
                        completion(nil)
                        return
                    }
                    let image = UIImage(data: data!)
                       completion(image);
    
                case .error(data: _, errorMessage: let error):
                    if error.noData(){
                        completion(UIImage(named: ImagesConstats.loadingErrorImage.rawValue));
                    }
                }
            }
            self.uuidMap[uuid] = task
        }
        return uuid
    }
    
    func cancelRequest(_ uuid: UUID){
        self.uuidMap[uuid]?.cancel()
        self.uuidMap.removeValue(forKey: uuid)
    }
}
