//
//  DashboardCell.swift
//  Proofofconcept
//
//  Created by Yuvraj Sorav on 13/12/20.
//

import UIKit

class DashboardCell: UITableViewCell {
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: Font.kSystemBold, size: 16)
        return label
    }()
    
    private let detailLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: Font.kSystemMedium, size: 12)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    private let profileImage : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = #imageLiteral(resourceName: "profile-picture")
        return image
    }()
    
    // MARK: Initalizers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        self.selectionStyle = .none
        let marginGuide = contentView.layoutMarginsGuide
        
        // configure profileImageView
        contentView.addSubview(profileImage)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        profileImage.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant:60.0).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        
        
        
        
        // configure titleLabel
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 5.0).isActive = true
        nameLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        
        nameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30.0).isActive = true
        
        // configure authorLabel
        contentView.addSubview(detailLabel)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 5.0).isActive = true
        detailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        detailLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        detailLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30.0).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:-  Setup Cell
    func setUpCell(_ dashboardArr: [DashboardRowModel], _ indexPath: IndexPath) {
        let dashBoardModel = dashboardArr[indexPath.row]
        nameLabel.text = dashBoardModel.title
        detailLabel.text = dashBoardModel.description
        profileImage.image = #imageLiteral(resourceName: "profile-picture")
        if let imageUrlStr = dashBoardModel.imageHref {
            loadImage(imageUrlStr)
        }
    }
    
    // MARK:-  Load Image
    private func loadImage(_ urlStr: String) {
        guard let url = URL(string: urlStr) else { return }
        POCNetworkManager.sharedManager.downloadImage(url: url) { (image, err) in
            if err == nil {
                DispatchQueue.main.async {
                    self.profileImage.image = image
                    self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width/2
                    self.profileImage.clipsToBounds = true
                }
            }
        }
    }
}

