//
//  DashboardViewModel.swift
//  Proofofconcept
//
//  Created by Yuvraj Sorav on 13/12/20.
//

import Foundation

struct DashboardViewModel {
    
    var titleStr: String?
    var rowsArr: [DashboardRowModel]?
    
    init(_ dashBoardModel: DashboardModel) {
        self.titleStr = dashBoardModel.title
        self.rowsArr = dashBoardModel.rows
    }
    
    static func getDashboardData(completionHandler: @escaping(DashboardViewModel?, String?) -> Void) {
        let urlStr = UrlConstant.kFacts
        POCNetworkManager.sharedManager.makeGetRequest(urlString: urlStr) { (result) in
            switch result {
            case .success(let data):
                do {
                    let dashboardMod = try JSONDecoder().decode(DashboardModel.self, from: data)
                    let dashBoardViewModel = DashboardViewModel(dashboardMod)
                    completionHandler(dashBoardViewModel, nil)
                }catch {
                    completionHandler(nil,error.localizedDescription)
                }
                
            case .failure(let err):
                completionHandler(nil,err.localizedDescription)
            }
        }
    }
    
}
