//
//  ImageListCell.swift
//  app-image-loading
//
//  Created by maxim mironov on 17.01.2021.
//  Copyright © 2021 maxim mironov. All rights reserved.
//

import Foundation
import UIKit
class ImageListCell: UITableViewCell {
    @IBOutlet weak var pic: UIImageView!
    var usecase: ImageLoadingUseCase!
    var isLoaded = false
    var succes = false

    func confugure(usecase: ImageLoadingUseCase) {
        self.usecase = usecase;
    }
    var cellImage: CellWithImageModel! {
        willSet(cellImage){
            self.setDefault()
            self.loadImage(imageUrl: cellImage.imageUrl)
        }
    }
    func setDefault(){
        self.pic.image = UIImage()
    }
    
    func loadImage(imageUrl:String) {
        self.pic.showLoading()
        self.succes = false
        self.usecase.getImage(url: imageUrl) {[unowned self] (data) in
            self.isLoaded = true
            guard let data = data else {
                DispatchQueue.main.async {
                    self.pic.image = UIImage(named: ImagesConstats.loadingErrorImage.rawValue)
                    self.pic.stopLoading()
                }
                return
            }
            self.succes = true
            DispatchQueue.main.async {
                self.pic.image = UIImage(data: data)
                self.pic.stopLoading()
            }
        }
    }
    func reloadImage()  {
        self.setDefault()
        self.loadImage(imageUrl: self.cellImage.imageUrl)
    }
    
}
