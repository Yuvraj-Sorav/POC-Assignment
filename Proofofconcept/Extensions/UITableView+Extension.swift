//
//  UITableView+Extension.swift
//  Proofofconcept
//
//  Created by Yuvraj Sorav on 13/12/20.
//

import UIKit

extension UITableView {

    func setNoDataMessage(_ message: String = StaticErrorMessage.noDataFoundMessage) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width - 32.0, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: Font.kSystemMedium, size: 21.0)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restoreData() {
        self.backgroundView = nil
    }
}
