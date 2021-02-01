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
    var loadindSuccess = false
    var token : UUID?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.setDefault()
        if let token = self.token{
            self.usecase.cancelRequest(token)
        }
    }
    
    func confugure(usecase: ImageLoadingUseCase) {
        self.usecase = usecase;
    }
    var cellImage: CellWithImageModel! {
        willSet(cellImage){
            self.setDefault()
        }
    }
    func setDefault(){
        self.pic.stopLoading()
        self.pic.image = nil
    }
    
    func loadImage(completion: (() -> Void)? = nil) {
        self.setDefault()
        self.loadindSuccess = false
        let imageUrl = self.cellImage.imageUrl
        self.pic.showLoading()
        DispatchQueue.global(qos: .background).async(execute: { () -> Void in
            self.token = self.usecase.getImage(url: imageUrl) { (image) in
                guard let image = image else {
                    self.pic.stopLoading()
                    return
                }
                self.loadindSuccess = true
                 DispatchQueue.main.async {
                    self.pic.image = image
                    self.pic.stopLoading()
                    if completion != nil {
                        completion!()
                    }
                }
            }
            
        })
    }
    func reloadImage(completion: @escaping () -> ())  {
        self.loadImage(completion: completion)
    }
    
}
