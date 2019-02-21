//
//  ExtensionViewController.swift
//  07_14_kuwahatasachio
//
//  Created by sachiokuwahata on 2019/02/21.
//  Copyright © 2019年 sachiokuwahata. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showIndicator(color: UIColor = .black) {
        
        let bounds = self.view.bounds
        let view = UIView(frame: bounds)
        view.backgroundColor = .gray
        view.alpha = 0.3
        
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.color = color
        indicator.center = view.center
        indicator.startAnimating()
        
        view.addSubview(indicator)
        self.view.addSubview(view)
    }
    
    func hideIndicator() {
        view.removeFromSuperview()
    }

}
