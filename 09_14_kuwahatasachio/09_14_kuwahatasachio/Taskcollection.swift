//
//  Taskcollection.swift
//  09_14_kuwahatasachio
//
//  Created by sachiokuwahata on 2019/02/04.
//  Copyright © 2019年 sachiokuwahata. All rights reserved.
//

import Foundation

class TaskCollection {
    
    static let shared = TaskCollection()
    var tasks: [Post] = []
    
    
    func addTask(name:String, id:String, latitude:String, longitude:String) {
        let task = Post()
        task.name = name
        task.id = id
        task.latitude = latitude
        task.longitude = longitude
        self.tasks.append(task)
    }
    
}
