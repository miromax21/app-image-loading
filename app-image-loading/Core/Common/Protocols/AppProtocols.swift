//
//  Coordinator.swift
//  app-image-loading
//
//  Created by maxim mironov on 07.04.2021.
//  Copyright © 2021 maxim mironov. All rights reserved.
//

import Foundation
import UIKit

protocol SceneDelegateApp {
    var app: AppProtocol! { get }
}

protocol AppProtocol {
    func start()
    func saveCobtext()
    var appCoordinator: AppCoordinator! {get}
}

protocol Coordinator: AnyObject {
    func start() -> UIViewController
}

