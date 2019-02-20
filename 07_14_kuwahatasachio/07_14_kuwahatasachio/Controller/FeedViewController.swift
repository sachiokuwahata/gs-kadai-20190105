//
//  FeedViewController.swift
//  07_14_kuwahatasachio
//
//  Created by sachiokuwahata on 2019/01/21.
//  Copyright © 2019年 sachiokuwahata. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController ,UITableViewDelegate ,UITableViewDataSource{
    
    var displayName = String()
    var userName = String()
    var posts = [Post]()
    var posst = Post()
    var menuDateKeys = [String]()
    var imageKyes: [String: String] = [:]
        
    @IBOutlet weak var tableview: UITableView!

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuDateKeys.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let imageView = cell.viewWithTag(1) as! UIImageView
        let dateTextLabel = cell.viewWithTag(5) as! UILabel
        let nameTextLabel = cell.viewWithTag(6) as! UILabel

        dateTextLabel.text = self.menuDateKeys[indexPath.row]
        nameTextLabel.text = self.displayName
        
        // URLへ変換
        let imageurl = URL(string: self.imageKyes[self.menuDateKeys[indexPath.row]] as! String)
        imageView.sd_setImage(with: imageurl, completed: nil)
        imageView.layer.cornerRadius = 8.0
        imageView.clipsToBounds = true

        var imageData:NSData = NSData()
        if let image = imageView.image {
                    imageData = image.jpegData(compressionQuality: 0.01)! as NSData
                }
        return cell
    }
    
    
    @objc func edit(_ sender:TableButton){
        print(sender.indexpath)
        
        let editVC = self.storyboard?.instantiateViewController(withIdentifier: "editVC") as! EditViewController

        // editVCへ編集データの受け渡し
        editVC.indexpath = sender.indexpath! // Int()
        editVC.menu = sender.menu! // String()
        editVC.date = sender.date! // String()
        editVC.number = sender.number! // String()
        editVC.weight = sender.weight! // String()
        editVC.key = sender.key! // String()
        editVC.imageData = sender.imageData! // NSData()
        
        self.navigationController?.pushViewController(editVC, animated: true)
        
    }
    
    func fetchPost() {
        
        self.posts = [Post]()
        let ref = Database.database().reference().child("postdata").child("\(self.userName)")
        let refImage = Database.database().reference().child("imageData").child("\(self.userName)")
        
        ref.observeSingleEvent(of: .value) { (snap,error) in
            let postsnap = snap.value as? [String:NSDictionary]
            if postsnap == nil {
                return
            }
            
            for (_,post) in postsnap! {
                self.posst = Post()
                
                if let date = post["date"] as! String?, let weight = post["weight"] as! String?, let number = post["number"] as! String?, let menu = post["menu"]  as! String?,let key = post["key"] as! String?, let imageData = post["imageData"] as! String?{
                    
                    self.posst.date = date
                    self.posst.weight = weight
                    self.posst.number = number
                    self.posst.menu = menu
                    self.posst.key = key
                    self.posst.imageData = imageData
                    
                }
                self.posts.append(self.posst)
                print("Date: \(self.posst.date)")
                print("Menu: \(self.posst.menu)")
            }
            
            refImage.observeSingleEvent(of: .value) { (snap,error) in
                let postsnap = snap.value as? [String:NSDictionary]
                if postsnap == nil {
                    return
                }
                
                for (_,post) in postsnap! {
                    if let date = post["date"] as! String?, let imageData = post["imageData"] as! String?{
                        self.imageKyes[date] = imageData
                    }
                    print(self.imageKyes)
                }
                self.Calculation()
                self.tableview.reloadData()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)


        // Facebook処理
        if let user = User.shared.firebaseAuth.currentUser?.uid {
            self.userName = user
        }

        // Facebook処理
        if let dName = User.shared.firebaseAuth.currentUser?.displayName {
            self.displayName = dName
        }
        fetchPost()
        tableview.reloadData()
    }

    
    func Calculation() {
        let DicMenu = Dictionary(grouping: self.posts, by: { $0.date })
        print("Gather: \(DicMenu)")
        self.menuDateKeys = [String](DicMenu.keys)
        if menuDateKeys == nil { return }
        print(self.menuDateKeys)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        
    }
    
    @IBAction func LogoutButton(_ sender: Any) {
        
        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
        let LogoutVC = storyboardMain.instantiateViewController(withIdentifier: "LogoutVC")
        self.present(LogoutVC, animated: true, completion: nil)
        
    }
    

}
