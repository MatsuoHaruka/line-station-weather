//
//  NextViewController.swift
//  ex6
//
//  Created by HARUKA on 8/5/15.
//  Copyright (c) 2015 HARUKA. All rights reserved.
//

import UIKit
import CoreLocation

class NextViewController: UIViewController,CLLocationManagerDelegate {
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    var lm: CLLocationManager!
    var longitude: CLLocationDegrees!
    var latitude: CLLocationDegrees!
    var lat : Double!
    var lon : Double!
    var address : String!
    
    var urlString : String? = nil
    var weather : String?
    var temp : String?
    var temp_max : String?
    var temp_min : String?
    

    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
        
        self.lm = CLLocationManager()
        self.longitude = CLLocationDegrees()
        self.latitude = CLLocationDegrees()
        
        self.lm.delegate = self
        
        lm.requestAlwaysAuthorization()
        
        lm.startUpdatingLocation()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //位置情報取得成功時
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
        latitude = newLocation.coordinate.latitude
        longitude = newLocation.coordinate.longitude
        lm.stopUpdatingLocation()
        println(latitude)
        println(longitude)
        println("Success!")
        makeDate()
        geocording()
    }
    
    //位置情報取得失敗時
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error!")
    }
    
    
    func roadView(){
        if self.weather == "Rain"{
            self.myImageView.image = UIImage(named: "rain.png")
        }else if self.weather == "Clouds"{
            self.myImageView.image = UIImage(named: "clouds.png")
        }else if self.weather == "Clear"{
            self.myImageView.image = UIImage(named: "clear.png")
        }
        var tempDouble = atof(self.temp!)
        var t = tempDouble - 273
        var maxDouble = atof(self.temp_max!)
        var max = maxDouble - 273
        var minDouble = atof(self.temp_min!)
        var min = minDouble - 273
        self.tempLabel.text = String("\(t)")
        self.maxLabel.text = String("\(max)")
        self.minLabel.text = String("\(min)")
        self.weatherLabel.text = self.weather!
    }
    
    
    //逆ジオコーディング
    func geocording(){
        let urlString1 = "https://maps.googleapis.com/maps/api/geocode/json?latlng="
        let urlString2 = "&sensor=true"
        var stringLat = latitude?.description
        var stringLon = longitude?.description
        let urlString3 = urlString1 + stringLat! + "," + stringLon! + urlString2
        println(urlString3)
        
        var url = NSURL(string: urlString3)
        var task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: {data,response,error in
            
            var json = JSON(data: data)
            
            var address = json["results"][0]["formatted_address"]
            self.address = "\(address)"
            
            println(self.address)
            
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.addressLabel.text = self.address
            })
        
        })
        task.resume()
        
    }
    
    
    func makeDate(){
        let urlString1 = "http://api.openweathermap.org/data/2.5/weather?lat="
        let urlString2 = "&lon="
        var stringLat = latitude?.description
        var stringLon = longitude?.description
        
        self.urlString = urlString1 + stringLat! + urlString2 + stringLon!
        println(urlString!)
        
        var url = NSURL(string: self.urlString!)
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
            })

        })
         println("task end")
        
        task.resume()
        println("makeDate end")
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
