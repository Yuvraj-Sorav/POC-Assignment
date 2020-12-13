//
//  Constant.swift
//  Proofofconcept
//
//  Created by Yuvraj Sorav on 13/12/20.
//

import UIKit

struct UrlConstant {
    static let kFacts = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
}

struct Font {
    static let kSystemMedium = "System-Medium"
    static let kSystemBold = "System-Bold"
}

struct DeviceSize {
    static let screenBounds = UIScreen.main.bounds
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenWidth = UIScreen.main.bounds.size.width
}

struct StaticErrorMessage {
    static let noDataFoundMessage = "No Data Found."
    static let somethingWentWrongMessage = "Something Went Wrong."
    static let noInternetMessage = "Please check your internet connection."
}

struct AccessibilityIdentifier {
    static let dashboardTableViewIdentifier = "table--dashboardTableView"
}
