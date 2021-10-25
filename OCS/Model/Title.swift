//
//  Title.swift
//  OCS
//
//  Created by Nizar Elhraiech on 23/10/2021.
//

import Foundation
struct Title :Decodable{
    let color : String?
    let type : String?
    let value : String?
    
    init(color : String , type: String , value : String) {
        self.color = color
        self.type = type
        self.value = value
    }
}
