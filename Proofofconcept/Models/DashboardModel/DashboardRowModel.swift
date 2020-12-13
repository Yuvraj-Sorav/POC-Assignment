//
//  DashboardRowModel.swift
//  Proofofconcept
//
//  Created by Yuvraj Sorav on 13/12/20.
//

import Foundation

struct DashboardRowModel: Codable {
    
    let title: String?
    let description: String?
    let imageHref: String?
    
    init(title: String, description: String, imageHref: String) {
        self.title = title
        self.description = description
        self.imageHref = imageHref
    }
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
        case imageHref = "imageHref"
    }
}
