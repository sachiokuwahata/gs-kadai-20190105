//
//  TotalingViewController.swift
//  07_14_kuwahatasachio
//
//  Created by sachiokuwahata on 2019/01/24.
//  Copyright © 2019年 sachiokuwahata. All rights reserved.
//

import UIKit
import Firebase

class TotalingViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    
    var posts = [Post]()
    var posst = Post()
    var userName = String()

    var totals = [Toatal]()
    var totaln = Toatal()

    @IBOutlet weak var tableview: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.totals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "totalcell", for: indexPath)
        
        let menuLabel = cell.viewWithTag(1) as! UILabel
        let intLabel = cell.viewWithTag(2) as! UILabel
        
        menuLabel.text = totals[indexPath.row].menu
        intLabel.text = String(totals[indexPath.row].number)
        
        return cell
    }

    
    
    @IBAction func toatalButton(_ sender: Any) {
        self.prepareData()
        tableview.reloadData()
    }
    
    
    private func prepareData() {
        let Dic = Dictionary(grouping: self.posts, by: { $0.menu })
        
        var menukeys = [String](Dic.keys)
        if menukeys == nil { return }

        self.totals = [Toatal]()
        
        for (menukey) in menukeys {
            self.totaln = Toatal()
            
            var totalnumber = Int()
            
            let menuNumCount = Dic[menukey]?.count as! Int
            let menuNum = menuNumCount - 1
            for i in 0...menuNum{
                print("menukey: \(menukey)")
                print("Dic[menukey]: \(Dic[menukey]?[i]) + / + \(i)")
                print("Dic[menukey]weight: \(Dic[menukey]?[i].number)")
                
                totalnumber = totalnumber + Int((Dic[menukey]?[i].number)!)!
                
            }
            
            self.totaln.menu = menukey
            self.totaln.number = totalnumber
            self.totals.append(self.totaln)
            print("self.totaln.menu: \(self.totaln.menu) + / +  \(self.totaln.number)")
        }
        
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
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchPost()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userName = UserDefaults.standard.object(forKey: "userName") as! String

        
        tableview.delegate = self
        tableview.dataSource = self
    }
    


}
