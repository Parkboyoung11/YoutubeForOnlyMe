//
//  Video.swift
//  YoutubeOnlyForMe
//
//  Created by VuHongSon on 10/3/17.
//  Copyright © 2017 VuHongSon. All rights reserved.
//

import UIKit

class SafeJsonObject: NSObject {
    override func setValue(_ value: Any?, forKey key: String) {
        let uppercasedFirstCharacter = String(key.characters.first!).uppercased()
        let range = key.startIndex..<key.index(key.startIndex, offsetBy: 1)
        let selectorString = key.replacingCharacters(in: range, with: uppercasedFirstCharacter)
        let selector = NSSelectorFromString("set\(selectorString):")
        let responds = self.responds(to: selector)
        if !responds {
            return
        }
        super.setValue(value, forKey: key)
    }
}

class Video: SafeJsonObject {
    var thumbnail_image_name : String?
    var title : String?
    var channel : Channel?
    var number_of_views : NSNumber?
    var duration: NSNumber?
    var date : NSDate?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "channel" {
            self.channel = Channel()
            self.channel?.setValuesForKeys(value as! [String: AnyObject])
        }else {
            super.setValue(value, forKey: key)
        }
    }
    
    init(dictionary: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dictionary)
    }
}

class Channel: SafeJsonObject {
    var name: String?
    var profile_image_name : String?
}
