//
//  Utils.swift
//  app-image-loading
//
//  Created by maxim mironov on 17.01.2021.
//  Copyright © 2021 maxim mironov. All rights reserved.
//

import Foundation
import Foundation
import Network

class Utils {
    
    static let shared = Utils()
    
    fileprivate let utilsQueue = DispatchQueue(label: "utilsQueue")
    lazy var isInternetAvailable : Bool = {
        return checkInternetConnection()
    }()

//MARK: privet Utils functions
    fileprivate func checkInternetConnection() -> Bool  {
        let monitor = NWPathMonitor()
        var connectionerror = false
        monitor.start(queue: self.utilsQueue)
        monitor.pathUpdateHandler   = { pathUpdateHandler in
             if !(pathUpdateHandler.status == .satisfied){
                connectionerror = true
             }
        }
        return connectionerror
    }
}

