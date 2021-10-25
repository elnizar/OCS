//
//  Content+Extensions.swift
//  OCS
//
//  Created by Nizar Elhraiech on 23/10/2021.
//

import Foundation

extension Content {
    enum CodingKeys: String , CodingKey {
        case title
        case subtitle
        case subtitlefocus
        case highlefticon
        case highrighticon
        case lowrightinfo
        case imageurl
        case fullscreenimageurl
        case id
        case detaillink
        case duration
        case playinfoid
        case season = "seasons"
        case pitch
    }
    
}
