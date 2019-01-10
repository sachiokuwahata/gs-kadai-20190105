//
//  ImageStockViewController.swift
//  05_14_kuwahatasachio
//
//  Created by sachiokuwahata on 2019/01/09.
//  Copyright © 2019年 sachiokuwahata. All rights reserved.
//

import UIKit

class ImageStockViewController: UIViewController {
    
    var passImage:UIImage = UIImage()
    
    
    @IBOutlet weak var detailImageView: UIImageView!
    
    @IBOutlet weak var detailvol2ImageView: UIImageView!
    
    @IBOutlet weak var detailvol3ImageView: UIImageView!
    
    @IBAction func reloadButton(_ sender: Any) {
        
        if UserDefaults.standard.object(forKey: "imageData1") as? NSData == nil {
            return
        } else {
            let imageDate:NSData = UserDefaults.standard.object(forKey: "imageData1") as! NSData
            detailImageView.image = UIImage(data:imageDate as Data)!
        }

        if UserDefaults.standard.object(forKey: "imageData2") as? NSData == nil {
            return
        } else {
            let imageDate:NSData = UserDefaults.standard.object(forKey: "imageData2") as! NSData
            detailvol2ImageView.image = UIImage(data:imageDate as Data)!
        }

        if UserDefaults.standard.object(forKey: "imageData3") as? NSData == nil {
            return
        } else {
            let imageDate:NSData = UserDefaults.standard.object(forKey: "imageData3") as! NSData
            detailvol3ImageView.image = UIImage(data:imageDate as Data)!
        }
        
    }
    
    
    override func viewDidLoad() {
    
//        if UserDefaults.standard.object(forKey: "imageData") as? NSData == nil {
//            return
//        } else {
//         let imageDate:NSData = UserDefaults.standard.object(forKey: "imageData") as! NSData
//         detailImageView.image = UIImage(data:imageDate as Data)!
//        }
        
        print("stock")
        super.viewDidLoad()
        //        print(passImage)
        //        detailImageView.image = passImage

    }

}
