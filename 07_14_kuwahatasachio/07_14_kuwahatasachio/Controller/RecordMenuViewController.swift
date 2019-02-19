//
//  RecordMenuViewController.swift
//  07_14_kuwahatasachio
//
//  Created by sachiokuwahata on 2019/01/21.
//  Copyright © 2019年 sachiokuwahata. All rights reserved.
//

import UIKit

class RecordMenuViewController: UIViewController ,UITableViewDelegate ,UITableViewDataSource{
    
    var posts = [Post]()
    var posst = Post()
    var data:NSData = NSData()
    var Today = String()
    
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var TodayDate: UILabel!
    
    
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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(menuTextField.isFirstResponder){
            menuTextField.resignFirstResponder()
        } else if(numberTextField.isFirstResponder){
            numberTextField.resignFirstResponder()
        } else if(weightTextField.isFirstResponder){
            weightTextField.resignFirstResponder()
        }
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        let userName = self.userName
        let keys = "damyy"
        
        for post in posts {
        
            let menu = post.menu
            let number = post.number
            let weight = post.weight
            let date = post.date
        
            RecordViewController.shared.dataSet(date: date,weight: weight,number: number,menu: menu,keys: keys,userName:userName,imageData:data)
        }
        
        RecordViewController.shared.imageSet(date: self.Today, userName:self.userName, imageData:data)
        
        let feedVC = self.storyboard?.instantiateViewController(withIdentifier: "feedVC") as! FeedViewController
        self.navigationController?.popViewController(animated: true)
        self.tabBarController!.selectedIndex = 2
        

    }

    
    @IBAction func addDataButton(_ sender: Any) {
        self.posst = Post()
        
        self.posst.date = self.Today
        self.posst.weight = self.weightText
        self.posst.number = self.numberText
        self.posst.menu = self.menuText
        
        self.posts.append(self.posst)
        
        UserDefaults.standard.set("0", forKey: "selectWeight")
        UserDefaults.standard.set("0", forKey: "selectNumber")
        UserDefaults.standard.set("---------", forKey: "selectMenu")
        
        menuTextField.text = UserDefaults.standard.object(forKey: "selectMenu") as! String
        weightTextField.text = UserDefaults.standard.object(forKey: "selectWeight") as! String
        numberTextField.text = UserDefaults.standard.object(forKey: "selectNumber") as! String
        
        print(self.posts)
        self.tableview.reloadData()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //Facebookｂ認証
        if let user = User.shared.firebaseAuth.currentUser?.uid {
            self.userName = user
        }

        menuText = UserDefaults.standard.object(forKey: "selectMenu") as! String
        weightText = UserDefaults.standard.object(forKey: "selectWeight") as! String
        numberText = UserDefaults.standard.object(forKey: "selectNumber") as! String
        dateText = UserDefaults.standard.object(forKey: "selectDate") as! String
        
        menuTextField.text = menuText
        weightTextField.text = weightText
        numberTextField.text = numberText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        pickedImageView.image = image

        TodayDate.text = Today
        
        if let image = pickedImageView.image {
            self.data = image.jpegData(compressionQuality: 0.01)! as NSData
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "celladd", for: indexPath)

        let menuLabel = cell.viewWithTag(1) as! UILabel
        let weightLabel = cell.viewWithTag(2) as! UILabel
        let numberLabel = cell.viewWithTag(3) as! UILabel

        menuLabel.text = self.posts[indexPath.row].menu
        weightLabel.text = self.posts[indexPath.row].weight
        numberLabel.text = self.posts[indexPath.row].number
        
        return cell
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
    
}
