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

    var userName = String()
    var posts = [Post]()
    var posst = Post()
    
    @IBOutlet weak var tableview: UITableView!
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // cell内のItemを紐づけ
        let imageView = cell.viewWithTag(1) as! UIImageView
        let menuTextLabel = cell.viewWithTag(2) as! UILabel
        let weightTextLabel = cell.viewWithTag(3) as! UILabel
        let numberTextLabel = cell.viewWithTag(4) as! UILabel
        let dateTextLabel = cell.viewWithTag(5) as! UILabel
        let nameTextLabel = cell.viewWithTag(6) as! UILabel
        
        menuTextLabel.text = posts[indexPath.row].menu
        weightTextLabel.text = posts[indexPath.row].weight
        numberTextLabel.text = posts[indexPath.row].number
        dateTextLabel.text = posts[indexPath.row].date
        nameTextLabel.text = self.userName
        // URLへ変換
        let imageurl = URL(string: self.posts[indexPath.row].imageData as String)!
        // imageDataをimageViewへ設定
        imageView.sd_setImage(with: imageurl, completed: nil)
        imageView.layer.cornerRadius = 8.0
        imageView.clipsToBounds = true
        
        var imageData:NSData = NSData()
        if let image = imageView.image {
            imageData = image.jpegData(compressionQuality: 0.01)! as NSData
        }

        
        // 編集用のButton作成
        let editButton = TableButton(frame: CGRect(x:300,y:20,width:40,height:10))
        editButton.setTitleColor(UIColor.gray, for: .normal)
        editButton.setTitle(">>>", for: .normal)
        editButton.titleLabel?.font =  UIFont.systemFont(ofSize: 15)
        
        // 作成したプロパティ
        editButton.indexpath = indexPath.row
        editButton.menu = posts[indexPath.row].menu
        editButton.date = posts[indexPath.row].date
        editButton.number = posts[indexPath.row].number
        editButton.weight = posts[indexPath.row].weight
        editButton.key = posts[indexPath.row].key
        //editButton.imageData = posts[indexPath.row].imageData
        editButton.imageData = imageData
        
        
        // editの実行
        editButton.addTarget(self, action: #selector(self.edit), for: UIControl.Event.touchUpInside)
        cell.addSubview(editButton)
        
        
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
        let ref = Database.database().reference().child("postdata").child("\(String(describing: self.userName))")
        
        ref.observeSingleEvent(of: .value) { (snap,error) in
            
            let postsnap = snap.value as? [String:NSDictionary]
//            print("postsnap：\(postsnap)")
//            print("postsnap?.keys：\(postsnap?.keys)")
            
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
            }
            self.tableview.reloadData()
        }
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.userName = UserDefaults.standard.object(forKey: "userName") as! String
        
        fetchPost()
        tableview.reloadData()
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
