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
    var list: [CellWithImageModel] = [] {
        didSet{
            view.tableView.reloadData()
        }
    }
    var service: Api
    var Output: UIViewController! {
         get{
             return self.view
         }
    }
    
    init(coordinator: BaseCoordinator!) {
        self.coordinator = coordinator
        self.service = URLSessionApiSrevices()
        self.useCaase = ImageLoadingUseCase()
        self.view = ImageListViewController()
        self.view.viewModel = self
    }
    
    func readDataImages(completion: @escaping (_ data: [CellWithImageModel]) ->()){
        var list:  [CellWithImageModel] = []
        for index in 1 ..< 101 {
            list.append(CellWithImageModel.init(image_number: index))
        }
        DispatchQueue.main.async {
            completion(list)
        }
    }
    
    func tapOnTheImage(image: CellWithImageModel){
        self.coordinator.appCoordinator.next(coordinator: .image(img: image))
    }
}

