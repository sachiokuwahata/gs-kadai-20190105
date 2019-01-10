//
//  ShareViewController.swift
//  05_14_kuwahatasachio
//
//  Created by sachiokuwahata on 2019/01/08.
//  Copyright © 2019年 sachiokuwahata. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {

    var shareImage:UIImage = UIImage()

    @IBOutlet weak var shareImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shareImageView.image = shareImage
    }
    

    @IBAction func postButton(_ sender: Any) {
        do {
            let activityViewController = UIActivityViewController(activityItems: [shareImage], applicationActivities: nil)
            
            present(activityViewController, animated: true, completion: nil)
            
        } catch let error {
            print(error)
        }

    }
    
}
