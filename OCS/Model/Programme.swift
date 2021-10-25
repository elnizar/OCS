//
//  Programme.swift
//  OCS
//
//  Created by Nizar Elhraiech on 23/10/2021.
//

import Foundation

struct Programme : Decodable {
    let title : String?
    let template : String?
    let parentalrating : Int?
    let offset : Int?
    let limit : String?
    var next : String?
    let previous : Int?
    let total : Int?
    let count : Int?
    let filter : Int?
    let sort : Int?
    let contents : [Content]?
    let error : String?
    init(title: String , template : String , parentalrating : Int , offset :Int , limit : String , next : String , previous : Int , total : Int , count : Int , filter : Int , sort : Int , contents : [Content],error : String) {
        self.title = title
        self.template = template
        self.parentalrating = parentalrating
        self.offset = offset
        self.limit = limit
        self.next = next
        self.previous = previous
        self.total = total
        self.count = count
        self.filter = filter
        self.sort = sort
        self.contents = contents
        self.error = error
    }
    
    init(from decoder : Decoder ) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        title = try? container.decode(String.self, forKey: .title)

        template = try? container.decode(String.self, forKey: .template)
        parentalrating = try? container.decode(Int.self, forKey: .parentalrating)
        offset = try? container.decode(Int.self, forKey: .offset)
        limit = try? container.decode(String.self, forKey: .limit)

        if let value = try? container.decode(Int.self, forKey: .next) {
            next = String(value)
        } else {
            next = try? container.decode(String.self, forKey: .next)
        }

        
        
        previous = try? container.decode(Int.self, forKey: .previous)

        total = try? container.decode(Int.self, forKey: .total)
        count = try? container.decode(Int.self, forKey: .count)

        filter = try? container.decode(Int.self, forKey: .filter)
        sort = try? container.decode(Int.self, forKey: .sort)
        
        contents = try? container.decode([Content].self, forKey: .contents)

        error = try? container.decode(String.self, forKey: .error)

    }
    
    
}
