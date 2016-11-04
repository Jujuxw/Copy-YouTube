//
//  Video.swift
//  Copy YouTube
//
//  Created by juju on 16/10/2016.
//  Copyright © 2016 juju. All rights reserved.
//

import UIKit

class Video: NSObject {
    var thumbnailImage: String?
    var title: String?
    var numberOfviews: NSNumber?
    
    var channel:Channel?
    
}

class Channel: NSObject {
    var profileImageName: String?
    var name: String?
    
}
