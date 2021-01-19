//
//  AppCoordinator.swift
//  app-image-loading
//
//  Created by maxim mironov on 17.01.2021.
//  Copyright © 2021 maxim mironov. All rights reserved.
//

import Foundation
import UIKit

final class AppCoordinator {
    
    var coordinator: Coordinator!
    var router: Router!

    init(window:UIWindow) {
         self.router = Router(navigationController: window.rootViewController?.navigationController ?? UINavigationController())
    }
    
    func next(coordinator: AppCoordinatorEnum) {
        let vc = getCoordinator(coordinator: coordinator)
        self.router.next(viewController: vc)
    }
    
    fileprivate func getCoordinator(coordinator: AppCoordinatorEnum) -> UIViewController {
        self.router.navigationController.navigationBar.isHidden = false
        switch coordinator {
            case .images :
                    return presentViewController(coordinator: ImageListCoordinator())
            case .image(let img):
                return presentViewController(coordinator: ShowImageCoordinator(image: img))
        }
       
        
    }
    
    fileprivate func presentViewController(coordinator : BaseCoordinator) -> UIViewController {
         coordinator.appCoordinator = self
         return coordinator.start()
    }
    
}
