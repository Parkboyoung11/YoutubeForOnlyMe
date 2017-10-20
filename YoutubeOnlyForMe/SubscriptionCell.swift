//
//  SubscriptionCell.swift
//  YoutubeOnlyForMe
//
//  Created by VuHongSon on 10/13/17.
//  Copyright © 2017 VuHongSon. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {
    override func fetchVideos() {
        ApiService.sharedInstance.fetchSubscriptionFeed { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
