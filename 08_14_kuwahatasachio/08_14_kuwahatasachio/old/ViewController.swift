//
//  ViewController.swift
//  08_14_kuwahatasachio
//
//  Created by sachiokuwahata on 2019/01/28.
//  Copyright © 2019年 sachiokuwahata. All rights reserved.
//

import UIKit
import Photos
import Alamofire
import SwiftyJSON

class ViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    
    @IBAction func grnavi(_ sender: Any) {
        
        print("push")
        
        let parameters:[String:Any] = [
            "keyid": "0c7a7a07f8484b6add7109fb9eec417f",
            "format": "json",
            "freeword": "肉",
            "pref":  "PREF13",
            "hit_per_page": 100
        ]
        
        let headers:HTTPHeaders = [
            "Contenttype": "application/json"
        ]
        
        Alamofire.request("https://api.gnavi.co.jp/RestSearchAPI/20150630/?callback=?", method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response: DataResponse<Any>) in
            print(response.response?.statusCode)
            print(response.result.value)
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.result.value)
            
            }
        }
        
    }
    
    @IBAction func camera(_ sender: Any) {
        
        let sourceType:UIImagePickerController.SourceType = UIImagePickerController.SourceType.camera
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            self.present(cameraPicker, animated: true, completion: nil)
            
        }else{
            print("エラー")
        }
    }
    
    
    @IBAction func album(_ sender: Any) {
        let sourceType:UIImagePickerController.SourceType = UIImagePickerController.SourceType.photoLibrary
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            self.present(cameraPicker, animated: true, completion: nil)
        }
        else{
            print("エラー")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //        if let pickedimage = info[.originalImage] as? UIImage {
        
        if let pickedimage = info[.editedImage] as? UIImage {
            
            let uploadVC = self.storyboard?.instantiateViewController(withIdentifier: "upload") as! uploadViewController
            uploadVC.image = pickedimage
            
//            performSegue(withIdentifier: "next", sender: nil)
            picker.dismiss(animated: true, completion: nil)
            self.navigationController?.pushViewController(uploadVC, animated: true)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        PHPhotoLibrary.requestAuthorization { (status) in
            switch(status){
            case .authorized:break
            case .denied:break
            case .notDetermined:break
            case .restricted:break
            }
        }
    }


}

