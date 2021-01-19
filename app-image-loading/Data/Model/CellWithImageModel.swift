//
//  CellWithImageModel.swift
//  app-image-loading
//
//  Created by maxim mironov on 18.01.2021.
//  Copyright © 2021 maxim mironov. All rights reserved.
//

import Foundation
import UIKit

class CellWithImageModel{
    
    let id: UUID
    var imageUrl: String
    var image: UIImage?
    
    init(image_number:Int){
        id = UUID()
        self.imageUrl = "http://placehold.it/375x150?text=\(image_number)"
    }
}
