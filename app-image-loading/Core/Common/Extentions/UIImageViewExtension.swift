//
//  UIImageViewExtension.swift
//  app-image-loading
//
//  Created by maxim mironov on 18.01.2021.
//  Copyright © 2021 maxim mironov. All rights reserved.
//

import Foundation
import UIKit
extension UIImageView {
    func downloadedFrom(url:String, service: Api) {
         self.showLoading()
         DispatchQueue.global(qos: .background).async {
            service.callAPI(request: URLRequest(url: URL(string: url)!)) { (responce) in
                var image = UIImage()
                switch responce{
                case .success(data: let data):
                    image =  UIImage(data: data!!) ?? UIImage()
                case .error(data: _, errorMessage: _):
                    self.image = nil
                }
                DispatchQueue.main.async { () -> Void in
                    self.image = image
                    self.stopLoading()
                 }
            }
            
        }
    }
}

