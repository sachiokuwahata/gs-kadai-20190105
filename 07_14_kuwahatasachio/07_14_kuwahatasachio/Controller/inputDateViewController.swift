//
//  inputDateViewController.swift
//  07_14_kuwahatasachio
//
//  Created by sachiokuwahata on 2019/01/26.
//  Copyright © 2019年 sachiokuwahata. All rights reserved.
//

import UIKit

class inputDateViewController: UIViewController ,UITextFieldDelegate{

    var yymmdd = String()
    let dateFormat = DateFormatter()
    let nowDate = NSDate()
    
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var datepicker: UIDatePicker!
    
    @IBAction func ok(_ sender: Any) {
        self.yymmdd = "\(datepicker.date)"
        dateFormat.dateFormat = "yyyy年MM月dd日"
        dateTextField.text = dateFormat.string(from: nowDate as Date)
        
        dateTextField.text = dateFormat.string(from: datepicker.date)
        UserDefaults.standard.set(dateTextField.text, forKey: "selectDate")
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dateTextField.delegate = self    }
    

}
