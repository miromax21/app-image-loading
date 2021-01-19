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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.setDefault()
        self.pic.isHidden = true;
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
        self.pic.image = nil
        self.pic.stopLoading()
    }
    
    func loadImage(completion: (() -> Void)? = nil) {
        self.setDefault()
        self.loadindSuccess = false
        let imageUrl = self.cellImage.imageUrl
        self.pic.showLoading()
        DispatchQueue.global(qos: .background).async(execute: { [unowned self] () -> Void in
            self.usecase.getImage(url: imageUrl) { [unowned self] (image, url) in
                guard let image = image else {
                    self.pic.stopLoading()
                    return
                }
                self.loadindSuccess = true
                if ((url != nil) && url!.elementsEqual(imageUrl)){
                     DispatchQueue.main.async {
                        self.pic.isHidden = false
                        self.pic.image = image
                        self.pic.stopLoading()
                        if completion != nil {
                            completion!()
                        }
                    }
                }
            }
            
        })
    }
    
    func reloadImage(completion: @escaping () -> ())  {
        self.loadImage(completion: completion)
    }
    
}
