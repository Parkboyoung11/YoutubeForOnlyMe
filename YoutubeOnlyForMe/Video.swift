//
//  Video.swift
//  YoutubeOnlyForMe
//
//  Created by VuHongSon on 10/3/17.
//  Copyright © 2017 VuHongSon. All rights reserved.
//

import UIKit

class Video: NSObject {
    var thumbnailImageName : String?
    var title : String?
    var channel : Channel?
    var numberOfViews : NSNumber?
    var date : NSDate?
}

class Channel: NSObject {
    var name: String?
    var profileImageName : String?
}
