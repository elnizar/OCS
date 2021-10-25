//
//  Contents.swift
//  OCS
//
//  Created by Nizar Elhraiech on 23/10/2021.
//

import Foundation
struct Content : Decodable{
    let title : [Title]?
    let subtitle : String?
    let subtitlefocus : String?
    let highlefticon : String?
    let highrighticon : String?
    let lowrightinfo : String?
    let imageurl : String?
    let fullscreenimageurl : String?
    let id : String?
    let detaillink : String?
    let duration : String?
    let playinfoid : Playinfoid?
    let season : [Season]?
    let pitch : String?

    init(title: [Title] , subtitle : String , subtitlefocus : String , highlefticon :String , highrighticon : String , lowrightinfo : String , imageurl : String , fullscreenimageurl : String , id : String , detaillink : String , duration : String , playinfoid : Playinfoid , season : [Season], pitch : String) {
        self.title = title
        self.subtitle = subtitle
        self.subtitlefocus = subtitlefocus
        self.highlefticon = highlefticon
        self.highrighticon = highrighticon
        self.lowrightinfo = lowrightinfo
        self.imageurl = imageurl
        self.fullscreenimageurl = fullscreenimageurl
        self.id = id
        self.detaillink = detaillink
        self.duration = duration
        self.playinfoid = playinfoid
        self.season = season
        self.pitch = pitch

    }
    
    init(from decoder : Decoder ) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        title = try? container.decode([Title].self, forKey: .title)

        subtitle = try? container.decode(String.self, forKey: .subtitle)
        subtitlefocus = try? container.decode(String.self, forKey: .subtitlefocus)
        highlefticon = try? container.decode(String.self, forKey: .highlefticon)
        highrighticon = try? container.decode(String.self, forKey: .highrighticon)

        lowrightinfo = try? container.decode(String.self, forKey: .lowrightinfo)
        imageurl = try? container.decode(String.self, forKey: .imageurl)

        fullscreenimageurl = try? container.decode(String.self, forKey: .fullscreenimageurl)
        id = try container.decode(String.self, forKey: .id)

        detaillink = try? container.decode(String.self, forKey: .detaillink)
        duration = try? container.decode(String.self, forKey: .duration)
        
        playinfoid = try? container.decode(Playinfoid.self, forKey: .playinfoid)

        season = try? container.decode([Season].self, forKey: .season)
        pitch = try? container.decode(String.self, forKey: .pitch)

    }
}
