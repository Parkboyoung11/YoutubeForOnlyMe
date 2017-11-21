//
//  VideoCell.swift
//  YoutubeOnlyForMe
//
//  Created by VuHongSon on 10/3/17.
//  Copyright © 2017 VuHongSon. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoCell : BaseCell {
    
    var video : Video? {
        didSet {
            titleLabel.text = video?.title
            
            setupThumbnailImage()
            setProfileImage()
        
            
            if let channelName = video?.channel?.name , let numberOfViews = video?.number_of_views {
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                
                let subtitleText = "\(channelName)・\(numberFormatter.string(from: numberOfViews)!)・2 years ago"
                self.subtitleTextView.text = subtitleText
            }
            
            if let title = video?.title {
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes:
                    [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
                
                if estimatedRect.size.height > 20 {
                    titleLabelHeightContraint?.constant = 44
                }else {
                    titleLabelHeightContraint?.constant = 20
                }
            }
        }
    }
    
    let thumbnailImageView : CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userProfileImageView : CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let separatorView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Taylor Swift - Blank Space"
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleTextView : UITextView = {
        let textView = UITextView()
        textView.textColor = UIColor.lightGray
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    var titleLabelHeightContraint : NSLayoutConstraint?
    
    func setupThumbnailImage() {
        if let thumbnailImageURL = video?.thumbnail_image_name {
            thumbnailImageView.loadImageFromURL(urlString: thumbnailImageURL)
        }
    }
    
    func setProfileImage() {
        if let profileImageURL = video?.channel?.profile_image_name {
            userProfileImageView.loadImageFromURL(urlString: profileImageURL)
        }
    }
    
    override func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        addContraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView, userProfileImageView, separatorView)
        addContraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addContraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        addContraintsWithFormat(format: "H:|-16-[v0(44)]", views: userProfileImageView)
        
        // top contraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        // left contraints
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        //right contraints
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        //height contraints
        titleLabelHeightContraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
        addConstraint(titleLabelHeightContraint!)
        
        // top contraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        // left contraints
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        //right contraints
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        //height contraints
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
    }
}
