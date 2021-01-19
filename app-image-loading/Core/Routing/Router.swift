//
//  Router.swift
//  app-image-loading
//
//  Created by maxim mironov on 17.01.2021.
//  Copyright © 2021 maxim mironov. All rights reserved.
//

import Foundation
import UIKit

indirect enum AppCoordinatorEnum{
    case images
    case image(img: CellWithImageModel)
}

class Router {
    
    var navigationController : UINavigationController
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    func next(viewController:UIViewController)  {
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
