//
//  FilterViewController.swift
//  05_14_kuwahatasachio
//
//  Created by sachiokuwahata on 2019/01/08.
//  Copyright © 2019年 sachiokuwahata. All rights reserved.
//

import UIKit
import CoreImage

class FilterViewController: UIViewController {

    var passImage: UIImage = UIImage()

    var ciContext: CIContext!
    
    @IBOutlet weak var editImageView: UIImageView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editImageView.image = passImage

    }
    

    @IBAction func shareButton(_ sender: Any) {
        performSegue(withIdentifier: "share", sender: nil)
        
//        UserDefaults.standard.set(UIImageJPEGRepresentation(editImageView.image!, 0.8), forKey: "imageData")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "share" {
            
            let shareVC: ShareViewController = segue.destination as! ShareViewController
            shareVC.shareImage = editImageView.image!

            let ImageStockVC = storyboard!.instantiateViewController(withIdentifier: "ImageStockViewController") as! ImageStockViewController
            
            // ImageStockVC.passImage = editImageView.image!
            
            // let imageDate:NSData = UserDefaults.standard.object(forKey: "imageData") as! NSData
            // ImageStockVC.passImage = UIImage(data:imageDate as Data)!
            
        }
    }
    
    
// フィルターの関数設定
    @IBAction func filter1(_ sender: Any) {
        let ciImage:CIImage = CIImage(image: editImageView.image!)!;
        let ciFilter:CIFilter = CIFilter(name: "CISepiaTone")!;
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        ciFilter.setValue(0.8, forKey: "inputIntensity")
        self.ciContext = CIContext(options: nil)
        let cgimg: CGImage = ciContext.createCGImage(ciFilter.outputImage!, from:ciFilter.outputImage!.extent)!
        //image2に加工イメージ
        
        let image2:UIImage = UIImage(cgImage: cgimg, scale: 1.0, orientation:UIImage.Orientation.right)
        
        editImageView.image = image2

        UserDefaults.standard.set(editImageView.image!.jpegData(compressionQuality: 0.8), forKey: "imageData1")

        let imageDate:NSData = UserDefaults.standard.object(forKey: "imageData1") as! NSData
        fixedImageView.image = UIImage(data:imageDate as Data)
        
        
    }
    

    @IBAction func filter2(_ sender: Any) {
        let ciImage:CIImage = CIImage(image: editImageView.image!)!;
        let ciFilter:CIFilter = CIFilter(name: "CIColorMonochrome")!;
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        ciFilter.setValue(CIColor(red:0.75, green:0.75, blue:0.75), forKey: "inputColor")
        ciFilter.setValue(1.0, forKey: "inputIntensity")
        self.ciContext = CIContext(options: nil)
        let cgimg: CGImage = ciContext.createCGImage(ciFilter.outputImage!, from:ciFilter.outputImage!.extent)!
        //image2に加工イメージ
        
        let image2:UIImage = UIImage(cgImage: cgimg, scale: 1.0, orientation:UIImage.Orientation.right)
        
        editImageView.image = image2

        UserDefaults.standard.set(editImageView.image!.jpegData(compressionQuality: 0.8), forKey: "imageData2")

        let imageDate:NSData = UserDefaults.standard.object(forKey: "imageData2") as! NSData
        fixedImageView.image = UIImage(data:imageDate as Data)

        
    }
    

    @IBAction func filter3(_ sender: Any) {
        let ciImage:CIImage = CIImage(image: editImageView.image!)!;
        let ciFilter:CIFilter = CIFilter(name: "CIFalseColor")!;
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        ciFilter.setValue(CIColor(red:0.44, green:0.5, blue:0.2), forKey: "inputColor0")
        ciFilter.setValue(CIColor(red:1, green:0.92, blue:0.50), forKey: "inputColor1")
        self.ciContext = CIContext(options: nil)
        let cgimg: CGImage = ciContext.createCGImage(ciFilter.outputImage!, from:ciFilter.outputImage!.extent)!
        //image2に加工イメージ
        
        let image2:UIImage = UIImage(cgImage: cgimg, scale: 1.0, orientation:UIImage.Orientation.right)
        
        editImageView.image = image2

        UserDefaults.standard.set(editImageView.image!.jpegData(compressionQuality: 0.8), forKey: "imageData3")

        let imageDate:NSData = UserDefaults.standard.object(forKey: "imageData3") as! NSData
        fixedImageView.image = UIImage(data:imageDate as Data)

        
    }
    

    @IBAction func filter4(_ sender: Any) {
        let ciImage:CIImage = CIImage(image: editImageView.image!)!;
        let ciFilter:CIFilter = CIFilter(name: "CIColorControls")!;
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        ciFilter.setValue(1.0, forKey: "inputSaturation")
        ciFilter.setValue(0.5, forKey: "inputBrightness")
        ciFilter.setValue(3.9, forKey: "inputContrast")
        self.ciContext = CIContext(options: nil)
        let cgimg: CGImage = ciContext.createCGImage(ciFilter.outputImage!, from:ciFilter.outputImage!.extent)!
        //image2に加工イメージ
        
        let image2:UIImage = UIImage(cgImage: cgimg, scale: 1.0, orientation:UIImage.Orientation.right)
        
        editImageView.image = image2
        
        UserDefaults.standard.set(editImageView.image!.jpegData(compressionQuality: 0.8), forKey: "imageData")

        let imageDate:NSData = UserDefaults.standard.object(forKey: "imageData") as! NSData
        fixedImageView.image = UIImage(data:imageDate as Data)

        
    }


    
    @IBOutlet weak var fixedImageView: UIImageView!
    

}
