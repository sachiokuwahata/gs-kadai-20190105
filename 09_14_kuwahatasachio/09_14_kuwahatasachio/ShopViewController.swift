//
//  ShopViewController.swift
//  09_14_kuwahatasachio
//
//  Created by sachiokuwahata on 2019/02/04.
//  Copyright © 2019年 sachiokuwahata. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import GoogleMaps


class ShopViewController: UIViewController ,UITableViewDataSource ,UITableViewDelegate{
    
    
    @IBOutlet weak var tableview: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskCollection.shared.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let shopname = cell.viewWithTag(1) as! UILabel
        shopname.text = TaskCollection.shared.tasks[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let shopid:String = TaskCollection.shared.tasks[indexPath.row].id
        let shoplat:String = TaskCollection.shared.tasks[indexPath.row].latitude
        let shoplon:String = TaskCollection.shared.tasks[indexPath.row].longitude
        print(shopid)
        print(shoplat)
        print(shoplon)
        
        let shopdetailVC = self.storyboard?.instantiateViewController(withIdentifier: "shopdetailVC") as! ShopDetailViewController
        shopdetailVC.id = TaskCollection.shared.tasks[indexPath.row].id
        shopdetailVC.shopname = TaskCollection.shared.tasks[indexPath.row].name
        self.navigationController?.pushViewController(shopdetailVC, animated: true)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        if let indexPathForSelectedRow = tableview.indexPathForSelectedRow {
            tableview.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
        UserDefaults.standard.set("----", forKey: "selectHardness")
        UserDefaults.standard.set("----", forKey: "selectTaste")
        UserDefaults.standard.set("----", forKey: "selectVolume")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        print(TaskCollection.shared.tasks)
    }

}
