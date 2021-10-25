//
//  Season.swift
//  OCS
//
//  Created by Nizar Elhraiech on 23/10/2021.
//

import Foundation
struct Season : Decodable{
    var pitch : String?
    
    init(pitch : String) {
        self.pitch = pitch
    }
}
