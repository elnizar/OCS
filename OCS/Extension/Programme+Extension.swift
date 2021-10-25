//
//  Programme+Extension.swift
//  OCS
//
//  Created by Nizar Elhraiech on 23/10/2021.
//

import Foundation
extension Programme {
    enum CodingKeys: String , CodingKey {
        case title
        case template
        case parentalrating
        case offset
        case limit
        case next
        case previous
        case total
        case count
        case filter
        case sort
        case contents
        case error
    }
}
