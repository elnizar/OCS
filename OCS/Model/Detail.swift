//
//  Contents.swift
//  OCS
//
//  Created by Nizar Elhraiech on 23/10/2021.
//

import Foundation
struct Detail : Decodable {
    
    let content : Content
    
    init(content : Content) {
        self.content = content
    }

    init(from decoder : Decoder ) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        
        content = try! container.decode(Content.self, forKey: .content)


    }

}
