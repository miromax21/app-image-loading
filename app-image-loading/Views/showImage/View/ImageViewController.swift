//
//  ImageViewCintroller.swift
//  app-image-loading
//
//  Created by maxim mironov on 18.01.2021.
//  Copyright © 2021 maxim mironov. All rights reserved.
//


import Foundation
import UIKit
class ImageViewCintroller: UIViewController{
    @IBOutlet var imageView: UIImageView!
    var viewModel: ImageViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadImage()
    }
    
    func loadImage() {
        self.imageView.showLoading()
        self.viewModel.useCaase.getImage(url: self.viewModel.image.imageUrl) { (data) in
            guard let data = data else {return}
            DispatchQueue.main.async { () -> Void in
               self.imageView.image = UIImage(data: data);
               self.imageView.stopLoading()
            }

        }
    }
}
