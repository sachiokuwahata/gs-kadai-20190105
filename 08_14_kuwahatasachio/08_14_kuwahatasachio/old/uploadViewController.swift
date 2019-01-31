//
//  uploadViewController.swift
//  08_14_kuwahatasachio
//
//  Created by sachiokuwahata on 2019/01/28.
//  Copyright © 2019年 sachiokuwahata. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class uploadViewController: UIViewController {

    var image = UIImage()
    @IBOutlet weak var displayImageView: UIImageView!
    
    
    @IBAction func judgeButton(_ sender: Any) {
        
        let url = "https://westcentralus.api.cognitive.microsoft.com/face/v1.0"
        guard let destURL = URL(string: url) else {
            return
        }
//
//        var request = URLRequest(url: destURL)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("649039a60506444f9f773808e1cbbb0b", forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
//
//        request.httpBody = image.jpegData(compressionQuality: 1)
//
//        Alamofire.request(request).responseJSON {response in
//            guard let object = response.result.value else { return }
//            print(response.response?.statusCode)
//            print(object)
//            let json = JSON(object)
//            print(json)
//        }

        let Parameters = [
            "returnFaceId": "true",
            "returnFaceLandmarks": "false",
            "returnFaceAttributes":
                "age,gender,headPose,smile,facialHair,glasses,emotion"
        ]
        
        let headers:HTTPHeaders = [
            "Content-Type": "application/json",
            "Ocp-Apim-Subscription-Key": "649039a60506444f9f773808e1cbbb0b"
        ]
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            if let imageData = self.image.jpegData(compressionQuality: 1) {
                multipartFormData.append(imageData, withName: "file", fileName: "file.png", mimeType: "image/png")
            }
            for (key, value) in Parameters {
                multipartFormData.append((value.data(using: .utf8))!, withName: key)
            }}, to: url, method: .post, headers: headers,
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):

                        upload.uploadProgress(closure: { (progress) in
                            print("Upload Progress: \(progress.fractionCompleted)")
                        }).responseJSON { response in
                            print(response.request)  // original URL request
                            print("response.error: \(response.error)")
                            print(response.response) // URL response
                            print(response.data)     // server data
                            print(response.result)   // result of response serialization
                            if let jsonDict = response.result.value as? NSDictionary {
                                print("jsonDict:\(jsonDict)")
                            }
                        }
                    case .failure(let encodingError):
                        print(encodingError)
                    }
        
                    
//                        upload.response { [weak self] response in
//                            guard let strongSelf = self else {
//                                return
//                            }
//                            debugPrint(response.response!.allHeaderFields)
//                        }
//                    case .failure(let encodingError):
//                        print("error:\(encodingError)")
//                    }

                    
        })
    }

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        displayImageView.image = image
    }

}

