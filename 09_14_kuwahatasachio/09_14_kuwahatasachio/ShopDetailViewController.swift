//
//  ShopDetailViewController.swift
//  09_14_kuwahatasachio
//
//  Created by sachiokuwahata on 2019/02/04.
//  Copyright © 2019年 sachiokuwahata. All rights reserved.
//

import UIKit

class ShopDetailViewController: UIViewController ,UITableViewDelegate ,UITableViewDataSource{
    
    let Recordobject = RecordCollection()
//    var records = Recordobject.records
    
    @IBOutlet weak var tableview: UITableView!
    
    var shopname = String()
    var id = String()
    
    @IBOutlet weak var hardnessLabel: UILabel!
    @IBOutlet weak var tasteLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    
    @IBOutlet weak var shopNameLabel: UILabel!
    
    @IBAction func recordButton(_ sender: Any) {

        let recordVC = storyboard!.instantiateViewController(withIdentifier: "recordVC") as! RecordViewController
        recordVC.id = self.id
        self.present(recordVC,animated: true, completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shopNameLabel.text = shopname
        
        tableview.dataSource = self
        tableview.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Recordobject.records: \(Recordobject.records)")
        print("ID: \(self.id)")
        if let newArray = UserDefaults.standard.object(forKey: "\(self.id)"){
            Recordobject.load(id: self.id)
            print("Recordobject.records: \(Recordobject.records)")
        }
        // ShopViewVCのLabelにデータを反映
        if let a = UserDefaults.standard.object(forKey: "selectHardness") as? String,
            let b = UserDefaults.standard.object(forKey: "selectTaste") as? String,
            let c = UserDefaults.standard.object(forKey: "selectVolume") as? String
        {
            hardnessLabel.text = a
            tasteLabel.text = b
            volumeLabel.text = c
        }
        tableview.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Recordobject.records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let cellvol1Label = cell.viewWithTag(1) as! UILabel
        let cellvol2Label = cell.viewWithTag(2) as! UILabel
        let cellvol3Label = cell.viewWithTag(3) as! UILabel
        
        cellvol1Label.text = Recordobject.records[indexPath.row].hardness
        cellvol2Label.text = Recordobject.records[indexPath.row].taste
        cellvol3Label.text = Recordobject.records[indexPath.row].volume
        
        return cell
    }

    // スワイプで削除
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//        // print(Recordobject.records[indexPath.row])
//        // print(Recordobject.records[indexPath.row].hardness)
//        Recordobject.removeRecord(at: indexPath.row, id: self.id)
//    }

    
}
