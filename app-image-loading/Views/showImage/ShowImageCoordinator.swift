//
//  ShowImageCoordinator.swift
//  app-image-loading
//
//  Created by maxim mironov on 18.01.2021.
//  Copyright © 2021 maxim mironov. All rights reserved.
//

import Foundation
import UIKit
class ShowImageCoordinator: BaseCoordinator {
    var image: CellWithImageModel?
    init(image: CellWithImageModel?) {
        self.image = image
    }
    override func start() -> UIViewController {
        self.viewModel = ImageViewModel(image: self.image)
        return super.start()
    }
}
