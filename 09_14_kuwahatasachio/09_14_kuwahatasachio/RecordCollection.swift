//
//  RecordCollection.swift
//  09_14_kuwahatasachio
//
//  Created by sachiokuwahata on 2019/02/04.
//  Copyright © 2019年 sachiokuwahata. All rights reserved.
//

import Foundation


class RecordCollection {
//    static let shared = RecordCollection()
    var records: [Record] = []
    var id = String()
    
    func addRecord(hardness:String,taste:String,volume:String,id:String){
        let record = Record()
        record.hardness = hardness
        record.taste = taste
        record.volume = volume
        self.id = id
        
        self.records.append(record)
        print(self.records)
        
        self.save()
        self.load(id:id)
    }
    
//    init () {
//        self.load()
//    }
    
    func save(){
        let data = try! PropertyListEncoder().encode(records)
        UserDefaults.standard.set(data, forKey: "\(self.id)")
    }
    
    func load(id:String){
        if let data = UserDefaults.standard.data(forKey: "\(id)"){
            let records = try! PropertyListDecoder().decode([Record].self, from: data)
            self.records = records
        }
    }
    
    func removeRecord (at: Int,id: String) {
        self.records.remove(at: at)
        self.id = id
        self.save()
    }
    
}
