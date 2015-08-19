//
//  weatherFavViewController.swift
//  ex6
//
//  Created by HARUKA on 8/12/15.
//  Copyright (c) 2015 HARUKA. All rights reserved.
//

import UIKit

class WeatherFav: NSObject, NSCoding {
    var lat : Double!
    var lon : Double!
    var address : String!
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        self.lat = aDecoder.decodeDoubleForKey("lat")
        self.lon = aDecoder.decodeDoubleForKey("lon")
        self.address = aDecoder.decodeObjectForKey("address") as! String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeDouble(self.lat!, forKey: "lat")
        aCoder.encodeDouble(self.lon!, forKey: "lon")
        aCoder.encodeObject(self.address!, forKey: "address")
    }
}
