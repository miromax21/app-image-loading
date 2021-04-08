//
//  ImageViewModel.swift
//  app-image-loading
//
//  Created by maxim mironov on 18.01.2021.
//  Copyright © 2021 maxim mironov. All rights reserved.
//

import Foundation
import UIKit

class ImageViewModel: ViewModelProtocol{
    
    var view: ImageViewController
    var image: CellWithImageModel
    var service: Api
    var useCaase: ImageLoadingUseCase!
    var Output: UIViewController! {
         get{
             return self.view
         }
    }
    
    init(image: CellWithImageModel!) {
        self.useCaase = ImageLoadingUseCase()
        self.image = image;
        self.service = URLSessionApiSrevices()
        self.view = ImageViewController()
        self.view.viewModel = self
    }
    
    func loadImage(completion: @escaping (UIImage?, String?) -> ()) {
        self.useCaase.getImage(url: self.image.imageUrl, completion: completion)
    }
}

