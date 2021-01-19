//
//  UIViewExtention.swift
//  app-image-loading
//
//  Created by maxim mironov on 18.01.2021.
//  Copyright © 2021 maxim mironov. All rights reserved.
//

import UIKit

extension UIView {
    
    static let loadingViewTag = 1938123987
    
    func showLoading(style: UIActivityIndicatorView.Style? = nil)  {
        var loadingStyle: UIActivityIndicatorView.Style
        if #available(iOS 13.0, *) {
            loadingStyle = UIActivityIndicatorView.Style.medium
        } else {
             loadingStyle = .whiteLarge
            // Fallback on earlier versions
        }
        if style != nil {
            loadingStyle = style ?? loadingStyle
        }
        var loading = viewWithTag(UIView.loadingViewTag) as? UIActivityIndicatorView
        if loading == nil {
            loading = UIActivityIndicatorView(style: loadingStyle)
        }

        loading?.translatesAutoresizingMaskIntoConstraints = false
        loading!.startAnimating()
        loading!.hidesWhenStopped = true
        loading?.tag = UIView.loadingViewTag
        addSubview(loading!)
        loading?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loading?.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func stopLoading() {
        let loading = viewWithTag(UIView.loadingViewTag) as? UIActivityIndicatorView
        loading?.stopAnimating()
        loading?.removeFromSuperview()
    }
}
