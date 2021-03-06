//
//  SettinngCell.swift
//  YoutubeOnlyForMe
//
//  Created by VuHongSon on 10/10/17.
//  Copyright © 2017 VuHongSon. All rights reserved.
//

import UIKit
class SettingCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
        }
    }
    
    var nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    var iconImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var setting : Setting? {
        didSet {
            nameLabel.text = setting?.name.rawValue
            if let iconName = setting?.iconName {
                iconImageView.image = UIImage(named: iconName)?.withRenderingMode(.alwaysTemplate)
                iconImageView.tintColor = UIColor.darkGray
            }
        }
    }
    
    override func setupViews() {
        super.setupViews()
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        addContraintsWithFormat(format: "H:|-8-[v0(30)]-8-[v1]|", views: iconImageView, nameLabel)
        addContraintsWithFormat(format: "V:[v0(30)]", views: iconImageView)
        addContraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        iconImageView.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor).isActive = true
    }
    
}
