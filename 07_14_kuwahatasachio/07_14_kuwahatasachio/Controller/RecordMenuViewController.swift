//
//  RecordMenuViewController.swift
//  07_14_kuwahatasachio
//
//  Created by sachiokuwahata on 2019/01/21.
//  Copyright © 2019年 sachiokuwahata. All rights reserved.
//

import UIKit

//class RecordMenuViewController: UIViewController ,UIPickerViewDelegate,UIPickerViewDataSource {
class RecordMenuViewController: UIViewController {

    
    var weightText = String()
    var numberText = String()
    var menuText = String()
    
//    let Input = InputViewController()
    var userName = String()
    var image = UIImage()
    
    @IBOutlet weak var pickedImageView: UIImageView!
    
    @IBOutlet weak var menuTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(menuTextField.isFirstResponder){
            menuTextField.resignFirstResponder()
        } else if(numberTextField.isFirstResponder){
            numberTextField.resignFirstResponder()
        } else if(weightTextField.isFirstResponder){
            weightTextField.resignFirstResponder()
        } else if(dateTextField.isFirstResponder){
            dateTextField.resignFirstResponder()
        }
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        let menu = menuTextField.text
        let number = numberTextField.text
        let weight = weightTextField.text
        let date = dateTextField.text
        let userName = self.userName
        let keys = "damyy"

        var data:NSData = NSData()
        if let image = pickedImageView.image {
            data = image.jpegData(compressionQuality: 0.01)! as NSData
        }

        RecordViewController.shared.dataSet(date: date!,weight: weight!,number: number!,menu: menu!,keys: keys,userName:userName,imageData:data)

        let feedVC = self.storyboard?.instantiateViewController(withIdentifier: "feedVC") as! FeedViewController
        self.navigationController?.pushViewController(feedVC, animated: true)

//        if let tabvc = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController {
//            DispatchQueue.main.async {
//                tabvc.selectedIndex = 0
//            }
//        }
//        // 移動先ViewControllerのインスタンスを取得（ストーリーボードIDから）
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let dstView = storyboard.instantiateViewController(withIdentifier: "feedVC")
//
//        self.tabBarController?.navigationController?.present(dstView, animated: true, completion: nil)

    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.userName = UserDefaults.standard.object(forKey: "userName") as! String

        menuText = UserDefaults.standard.object(forKey: "selectMenu") as! String
        weightText = UserDefaults.standard.object(forKey: "selectWeight") as! String
        numberText = UserDefaults.standard.object(forKey: "selectNumber") as! String
        
        menuTextField.text = menuText
        weightTextField.text = weightText
        numberTextField.text = numberText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickedImageView.image = image

    }
    

    var selectNumber = String()
    var selectWeight = String()
    
    @IBAction func numberButton(_ sender: Any) {
        
        let inputRecordvol2 = storyboard!.instantiateViewController(withIdentifier: "inputRecordvol2")
        self.present(inputRecordvol2,animated: true, completion: nil)

    }
    
    
    @IBAction func menuButton(_ sender: Any) {

        let inputMenu = storyboard!.instantiateViewController(withIdentifier: "inputMenu")
        self.present(inputMenu,animated: true, completion: nil)

    }
    
// Button削除
//    @IBAction func weightButton(_ sender: Any) {
//
//        let inputRecord = storyboard!.instantiateViewController(withIdentifier: "inputRecord")
//        self.present(inputRecord,animated: true, completion: nil)
//
//    }
    
}
