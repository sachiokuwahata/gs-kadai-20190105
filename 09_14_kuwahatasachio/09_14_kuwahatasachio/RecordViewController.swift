//
//  RecordViewController.swift
//  09_14_kuwahatasachio
//
//  Created by sachiokuwahata on 2019/02/04.
//  Copyright © 2019年 sachiokuwahata. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController ,UIPickerViewDelegate,UIPickerViewDataSource{
    
    let Recordobject = RecordCollection()
    var id = String()
    
    @IBOutlet weak var pickerview: UIPickerView!

    let dataList_array1 = ["","硬め","普通","柔らかめ"]
    let dataList_array2 = ["","濃いめ","普通","薄め"]
    let dataList_array3 = ["","多め","普通","少なめ"]

    var selectHardness = String()
    var selectTaste = String()
    var selectVolume = String()

    
    @IBAction func saveButton(_ sender: Any) {

        UserDefaults.standard.set(self.selectHardness, forKey: "selectHardness")
        UserDefaults.standard.set(self.selectTaste, forKey: "selectTaste")
        UserDefaults.standard.set(self.selectVolume, forKey: "selectVolume")
        UserDefaults.standard.set(self.id, forKey: "selectId")
        
         Recordobject.addRecord(hardness: self.selectHardness, taste: self.selectTaste, volume: self.selectVolume, id: self.id)
        
        self.dismiss(animated: true, completion: nil)

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return self.dataList_array1.count
        } else if component == 1 {
            return self.dataList_array2.count
        } else {
            return self.dataList_array3.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        if component == 0 {
            return self.dataList_array1[row]
        } else if component == 1 {
            return self.dataList_array2[row]
        } else {
            return self.dataList_array3[row]
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if component == 0 {
            self.selectHardness = self.dataList_array1[row]
            print(self.dataList_array1[row])
        } else if component == 1 {
            self.selectTaste = self.dataList_array2[row]
            print(self.dataList_array2[row])
        } else {
            self.selectVolume = self.dataList_array3[row]
            print(self.dataList_array3[row])
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerview.delegate = self
        pickerview.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("ID: \(self.id)")
        if let newArray = UserDefaults.standard.object(forKey: "\(self.id)"){
            Recordobject.load(id: self.id)
//            print("Recordobject.records: \(Recordobject.records)")
        }

    }
    
}
