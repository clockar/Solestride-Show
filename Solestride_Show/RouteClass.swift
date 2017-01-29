//
//  RouteClass.swift
//  Solestride_Show
//
//  Created by Keenan Rebera on 9/19/16.
//  Copyright © 2016 Keenan Rebera. All rights reserved.
//

import Foundation
import UIKit

class Route {
    
    var timesSaved: Int
    let distance: Float
    let title: String
    let creator_User: User
    var favorited: Bool = false
    
    init(timesSaved: Int, distance: Float, title: String, creator_User: User, favorited: Bool) {
        self.timesSaved = timesSaved
        self.distance = distance
        self.title = title
        self.creator_User = creator_User
        self.favorited = favorited
    }
    
}

class User {
    
    let handle: String
    let profile: UIImage
    
    convenience init(handle: String) {
        self.init(handle: handle, profile: #imageLiteral(resourceName: "sample_avatar"))
    }
    
    init(handle: String, profile: UIImage){
        self.handle = handle
        self.profile = profile
    }
    
}
