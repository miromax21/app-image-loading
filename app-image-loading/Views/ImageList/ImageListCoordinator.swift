//
//  ImageListCoordinator.swift
//  app-image-loading
//
//  Created by maxim mironov on 17.01.2021.
//  Copyright © 2021 maxim mironov. All rights reserved.
//
import UIKit

class ImageListCoordinator: BaseCoordinator {

    override func start() -> UIViewController {
        self.viewModel = ImageListViewModel(coordinator: self)
        return super.start()
    }
}
