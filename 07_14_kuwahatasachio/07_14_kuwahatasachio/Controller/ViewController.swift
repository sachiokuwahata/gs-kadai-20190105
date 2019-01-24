//
//  ViewController.swift
//  07_14_kuwahatasachio
//
//  Created by sachiokuwahata on 2019/01/21.
//  Copyright © 2019年 sachiokuwahata. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var userNameTextField: UITextField!
    
    
    
    @IBAction func nextButton(_ sender: Any) {
    
        if let userName = userNameTextField.text {
            UserDefaults.standard.set(userName, forKey: "userName")
        }
        performSegue(withIdentifier: "next", sender: nil)
        
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

