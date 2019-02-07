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
    var dateText = String()
    
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
        
        guard let menu = menuTextField.text else{ return }
        guard let number = numberTextField.text else{ return }
        guard let weight = weightTextField.text else{ return }
        guard let date = dateTextField.text else{ return }
        let userName = self.userName
        let keys = "damyy"

        var data:NSData = NSData()
        if let image = pickedImageView.image {
            data = image.jpegData(compressionQuality: 0.01)! as NSData
        }

            RecordViewController.shared.dataSet(date: date,weight: weight,number: number,menu: menu,keys: keys,userName:userName,imageData:data)

        let feedVC = self.storyboard?.instantiateViewController(withIdentifier: "feedVC") as! FeedViewController
        self.navigationController?.popViewController(animated: true)
        self.tabBarController!.selectedIndex = 2
        

    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.userName = UserDefaults.standard.object(forKey: "userName") as! String

        menuText = UserDefaults.standard.object(forKey: "selectMenu") as! String
        weightText = UserDefaults.standard.object(forKey: "selectWeight") as! String
        numberText = UserDefaults.standard.object(forKey: "selectNumber") as! String
        dateText = UserDefaults.standard.object(forKey: "selectDate") as! String
        
        menuTextField.text = menuText
        weightTextField.text = weightText
        numberTextField.text = numberText
        dateTextField.text = dateText
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
    
    
    @IBAction func dateButton(_ sender: Any) {
        let inputDate = storyboard!.instantiateViewController(withIdentifier: "inputDate")
        self.present(inputDate,animated: true, completion: nil)
    }
    
}
