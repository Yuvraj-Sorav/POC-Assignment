//
//  DashboardModel.swift
//  Proofofconcept
//
//  Created by Yuvraj Sorav on 13/12/20.
//

import Foundation

struct DashboardModel: Decodable {

    let title: String?
    let rows: [DashboardRowModel]?
    
    init(title: String, rowsArr: [DashboardRowModel]) {
        self.title = title
        self.rows = rowsArr
    }
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case rows = "rows"
    }
}
