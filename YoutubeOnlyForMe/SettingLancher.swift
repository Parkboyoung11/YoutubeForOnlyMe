//
//  SettingLancher.swift
//  YoutubeOnlyForMe
//
//  Created by VuHongSon on 10/10/17.
//  Copyright © 2017 VuHongSon. All rights reserved.
//

import UIKit

class Setting : NSObject{
    var name : SettingName
    var iconName : String
    
    init(name : SettingName, iconName : String) {
        self.name = name
        self.iconName = iconName
    }
}

enum SettingName : String {
    case Settings = "Settings"
    case Terms = "Terms & privacy policy"
    case Feedback = "Send Feedback"
    case Help = "Help"
    case SwitchAccount = "Switch Account"
    case Cancel = "Cancel"
}

class SettingLancher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    let settings : [Setting] = {
        return [Setting(name: .Settings, iconName: "settings"), Setting(name: .Terms, iconName: "privacy"), Setting(name: .Feedback, iconName: "feedback"), Setting(name: .Help, iconName: "help"), Setting(name: .SwitchAccount, iconName: "switch_account"), Setting(name: .Cancel, iconName: "cancel")]
    }()
    

    
    let cellID = "cellid"
    let cellHeight : CGFloat = 50
    var homeController : HomeController?
    
    let blackView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        return view
    }()
    
    let collectionView : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return cv
    }()
    
    func showSetting() {
        if let window = UIApplication.shared.keyWindow {
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hanldeDismiss)))
            blackView.alpha = 0
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            blackView.frame = window.frame
            
            let heigh : CGFloat = CGFloat(settings.count) * cellHeight
            let y = window.frame.height - heigh
            
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: heigh)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
        }
    }
    
    func hanldeDismiss(setting : Setting) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }) { (completed : Bool) in
            if setting.name != .Cancel {
                self.homeController?.showControllerForSetting(setting: setting)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SettingCell
        let setting = settings[indexPath.item]
        cell.setting = setting
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = settings[indexPath.item]
        hanldeDismiss(setting : setting)
        
        
    }
    
    override init() {
        super.init()
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}
