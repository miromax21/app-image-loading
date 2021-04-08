//
//  ImageViewCintroller.swift
//  app-image-loading
//
//  Created by maxim mironov on 18.01.2021.
//  Copyright © 2021 maxim mironov. All rights reserved.
//


import Foundation
import UIKit

class ImageViewController: UIViewController{
    
    @IBOutlet var imageView: UIImageView!
    
    unowned var viewModel: ImageViewModel! {
        didSet{
            self.loadImage()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.edgesForExtendedLayout = .top
    }
    
    func loadImage() {
        if self.imageView != nil{
            self.imageView.showLoading()
        }
        self.viewModel.loadImage { (img, _) in
            guard let img = img else {return}
               DispatchQueue.main.async { () -> Void in
                  self.imageView.image = img
                  self.imageView.stopLoading()
               }
        }
    }
}
