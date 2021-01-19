//
//  Aplication.swift
//  app-image-loading
//
//  Created by maxim mironov on 18.01.2021.
//  Copyright © 2021 maxim mironov. All rights reserved.
//

import Foundation
import UIKit

class App : AppProtocol {
    
    var appCoordinator: AppCoordinator!
    var window : UIWindow!
    var coreDataUsecase = CoreDataUseCase()
    
    init(window : UIWindow){
        self.window = window
        self.configureApp()
        self.start()
    }
    
    func start() {
        self.appCoordinator.next(coordinator: .images)
        self.window.rootViewController = self.appCoordinator.router.navigationController
        self.window.makeKeyAndVisible()
    }
    
    func saveCobtext() {
        self.coreDataUsecase.saveContext()
    }
    
// MARK: confuguration
    fileprivate func configureApp(){
        self.appCoordinator = AppCoordinator(window: self.window)
    }
}
