//
//  WeatherMakeData.swift
//  ex6
//
//  Created by HARUKA on 9/2/15.
//  Copyright (c) 2015 HARUKA. All rights reserved.
//

import UIKit
import SwiftyJSON


class WeatherMakeData: NSObject {
    
    var lat : Double!
    var lon : Double!
    var address : String!
    
    var weather : String!
    var temp : String!
    var temp_max : String!
    var temp_min : String!
    
    var max : Double!
    var min : Double!
    var t : Double!
    
    var imageName : String!
    
    override init() {
        super.init()
    }
    
    func make(){
        let urlString1 = "http://api.openweathermap.org/data/2.5/weather?lat="
        let urlString2 = "&lon="
        let stringLat = lat.description
        let stringLon = lon.description
        
        let urlString = urlString1 + stringLat + urlString2 + stringLon
        
        
        
    }
    
    func makeData(completion : () -> Void){
        
        let urlString1 = "http://api.openweathermap.org/data/2.5/weather?lat="
        let urlString2 = "&lon="
        let urlString3 = "&APPID=cbcf857a1bb19b0ee0132321660fd519"
        let stringLat = lat.description
        let stringLon = lon.description
        
        let urlString = urlString1 + stringLat + urlString2 + stringLon + urlString3
        
        let url = NSURL(string: urlString)
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: {data,response,error in
            
            var json = JSON(data: data!)
      
            
            let weather = json["weather"][0]["main"]
            self.weather = "\(weather)"
            print(weather)
            
            let temp = json["main"]["temp"]
            self.temp = "\(temp)"
            let temp_max = json["main"]["temp_max"]
            self.temp_max = "\(temp_max)"
            let temp_min = json["main"]["temp_min"]
            self.temp_min = "\(temp_min)"
            
            dispatch_async(dispatch_get_main_queue(), { () ->  Void in
                self.roadView()
                completion()
            })
            
        })
     
        print("task end")
        
        task.resume()
        print("makeDate end")

        
    }
    
    func roadView(){
        print(self.weather)
        if self.weather == "Rain"{
        self.imageName = "rain.png"
        }else if self.weather == "Clouds"{
        self.imageName = "clouds.png"
        }else if self.weather == "Clear"{
        self.imageName = "clear.png"
        }else if self.weather == "Thunderstorm"{
        self.imageName = "thunderstorm.png"
        }

        let tempDouble = atof(self.temp!)
        self.t = tempDouble - 273
        let
        maxDouble = atof(self.temp_max!)
        self.max = maxDouble - 273
        let minDouble = atof(self.temp_min!)
        self.min = minDouble - 273
        print(self.max)
        print("roadView end")
        
    }
   
}
