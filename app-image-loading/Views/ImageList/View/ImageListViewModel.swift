//
//  ImageListViewModel.swift
//  app-image-loading
//
//  Created by maxim mironov on 17.01.2021.
//  Copyright © 2021 maxim mironov. All rights reserved.
//

import Foundation
import UIKit

class ImageListViewModel: ViewModelProtocol{
    
    var view: ImageListViewController
    var coordinator: BaseCoordinator!
    var useCaase: ImageLoadingUseCase!
    var service: Api
    
    var list: [CellWithImageModel]!
    var Output: UIViewController! {
         get{
             return self.view
         }
    }
    
    init(coordinator: BaseCoordinator!) {
        self.list = []
        self.coordinator = coordinator
        self.service = URLSessionApiSrevices()
        self.useCaase = ImageLoadingUseCase()
        self.view = ImageListViewController()
        self.view.viewModel = self
    }
    
    func readDataImages(completion: @escaping () ->()){
        var list:  [CellWithImageModel] = []
        for index in 1 ..< 101 {
            list.append(CellWithImageModel.init(image_number: index))
        }
        self.list = list
        DispatchQueue.main.async {
            completion()
        }
    }
    
    func tapOnTheImage(image: CellWithImageModel){
        self.coordinator.appCoordinator.next(coordinator: .image(img: image))
    }
}

