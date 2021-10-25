//
//  Playinfoid.swift
//  OCS
//
//  Created by Nizar Elhraiech on 23/10/2021.
//

import Foundation

struct Playinfoid : Decodable {
    let hd : String?
    let sd : String?
    let uhd : String?
    
    init(hd : String , sd: String , uhd : String) {
        self.hd = hd
        self.sd = sd
        self.uhd = uhd
    }
}
