//
//  BaseCoordinator.swift
//  app-image-loading
//
//  Created by maxim mironov on 17.01.2021.
//  Copyright © 2021 maxim mironov. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    func start() -> UIViewController
}

class BaseCoordinator: Coordinator {
    var appCoordinator: AppCoordinator!
    var viewModel: ViewModelProtocol!
    func start() -> UIViewController{
        return self.viewModel.Output
    }
}
