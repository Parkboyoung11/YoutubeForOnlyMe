//
//  ManuBar.swift
//  YoutubeOnlyForMe
//
//  Created by VuHongSon on 10/3/17.
//  Copyright © 2017 VuHongSon. All rights reserved.
//

import UIKit

class MenuBar : UIView, UICollectionViewDataSource , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let imageNames = ["home", "trending", "subscriptions", "account"]
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: "cellID")
        
        addSubview(collectionView)
        
        addContraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addContraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .top)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! MenuCell
        cell.imageView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 4, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

class MenuCell : BaseCell {
    
    let imageView : UIImageView = {
        let iv = UIImageView()
//        iv.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
//        iv.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        return iv
    }()
    
    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    override func setupViews() {
        super.setupViews()
        addSubview(imageView)
        addContraintsWithFormat(format: "H:[v0(28)]", views: imageView)
        addContraintsWithFormat(format: "V:[v0(28)]", views: imageView)
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
