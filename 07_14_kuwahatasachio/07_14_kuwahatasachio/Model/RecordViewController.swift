//
//  RecordViewController.swift
//  07_14_kuwahatasachio
//
//  Created by sachiokuwahata on 2019/01/21.
//  Copyright © 2019年 sachiokuwahata. All rights reserved.
//

import UIKit
import Firebase

class RecordViewController: UIViewController {
    
    static let shared = RecordViewController()
    
    func dataSet(date: String,weight: String,number: String,menu: String,keys: String,userName:String, imageData:NSData){

        let rootref = Database.database().reference(fromURL: "https://muscleshow-b3569.firebaseio.com/").child("postdata").child("\(userName)")

        let storage = Storage.storage().reference(forURL: "gs://muscleshow-b3569.appspot.com/")
        
        if keys == "damyy" {

            let key = rootref.childByAutoId().key
            let imageRef = storage.child("\(userName)").child("\(key).jpg")
            
            let uploadTask = imageRef.putData(imageData as Data, metadata: nil) { (metadata, error) in
                
                if error != nil {
                    //SVProgressHUD.show()
                    return
                }

                imageRef.downloadURL(completion: { (url, error) in
                    let feed = ["date":date, "weight":weight, "number":number ,"menu":menu, "key": key, "imageData": url?.absoluteString]
                    let postFeed = ["\(key)":feed]
                    
                    rootref.updateChildValues(postFeed)
                    //SVProgressHUD.dismiss()
                })
            }
            uploadTask.resume()
            self.dismiss(animated: true, completion: nil)
            
        } else {
            let key = keys as? String
            let imageRef = storage.child("\(userName)").child("\(key).jpg")
            
            let uploadTask = imageRef.putData(imageData as Data, metadata: nil) { (metadata, error) in
                
                if error != nil {
                    //SVProgressHUD.show()
                    return
                }
                
                imageRef.downloadURL(completion: { (url, error) in
                    let feed = ["date":date, "weight":weight, "number":number ,"menu":menu, "key": key, "imageData": url?.absoluteString]
                    let postFeed = ["\(key)":feed]
                    
                    rootref.updateChildValues(postFeed)
                    //SVProgressHUD.dismiss()
                })
            }
            uploadTask.resume()
            self.dismiss(animated: true, completion: nil)

            
//            let feed = ["date":date, "weight":weight, "number":number ,"menu":menu, "key": key]
//            let postFeed = ["\(key)":feed]
//            rootref.updateChildValues(postFeed)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
