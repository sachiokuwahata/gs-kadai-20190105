//
//  Record.swift
//  09_14_kuwahatasachio
//
//  Created by sachiokuwahata on 2019/02/04.
//  Copyright © 2019年 sachiokuwahata. All rights reserved.
//

import Foundation

class Record:Codable {
    
    var hardness:String = String()
    var taste:String = String()
    var volume:String = String()

    enum CodingKeys: String, CodingKey {
        case hardness
        case taste
        case volume
    }
    
    init() {
        
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.hardness = try container.decode(String.self, forKey: .hardness)
        self.taste = try container.decode(String.self, forKey: .taste)
        self.volume = try container.decode(String.self, forKey: .volume)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(hardness, forKey: .hardness)
        try container.encode(taste, forKey: .taste)
        try container.encode(volume, forKey: .volume)
    }

    
}
