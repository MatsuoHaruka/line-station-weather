//
//  WeatherMakeData.swift
//  ex6
//
//  Created by HARUKA on 9/2/15.
//  Copyright (c) 2015 HARUKA. All rights reserved.
//

import UIKit

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
    
    func makeData(completion : () -> Void){
        
        let urlString1 = "http://api.openweathermap.org/data/2.5/weather?lat="
        let urlString2 = "&lon="
        var stringLat = lat.description
        var stringLon = lon.description
        
        let urlString = urlString1 + stringLat + urlString2 + stringLon
        
        var url = NSURL(string: urlString)
        var task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: {data,response,error in
            
            var json = JSON(data: data)
            var weather = json["weather"][0]["main"]
            self.weather = "\(weather)"
            println(weather)
            
            var temp = json["main"]["temp"]
            self.temp = "\(temp)"
            var temp_max = json["main"]["temp_max"]
            self.temp_max = "\(temp_max)"
            var temp_min = json["main"]["temp_min"]
            self.temp_min = "\(temp_min)"
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.roadView()
                completion()
            })
            
        })
        println("task end")
        
        task.resume()
        println("makeDate end")

        
    }
    
    func roadView(){
        
        if self.weather == "Rain"{
        self.imageName = "rain.png"
        }else if self.weather == "Clouds"{
        self.imageName = "clouds.png"
        }else if self.weather == "Clear"{
        self.imageName = "clear.png"
        }else if self.weather == "Thunderstorm"{
        self.imageName = "thunderstorm.png"
        }

        var tempDouble = atof(self.temp!)
        self.t = tempDouble - 273
        var maxDouble = atof(self.temp_max!)
        self.max = maxDouble - 273
        var minDouble = atof(self.temp_min!)
        self.min = minDouble - 273
        println(self.max)
        println("roadView end")
        
    }
   
}
