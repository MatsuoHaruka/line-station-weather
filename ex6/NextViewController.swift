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
    
    
    @IBOutlet weak var favoriteBtn: UIButton!
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
    var favAddress : String!
    
    var urlString : String? = nil
    var weather : String?
    var temp : String?
    var temp_max : String?
    var temp_min : String?
    
    var fav = WeatherFav()

    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
        
        
//        //お気に入りボタン
//        fav.lon = self.longitude
//        fav.lat = self.latitude
//        fav.address = self.addressLabel.text
//        
//        //シリアライズ
//        var dataFav : NSData = NSKeyedArchiver.archivedDataWithRootObject(fav)
//        
//        let ud = NSUserDefaults.standardUserDefaults()
//        
//        var favArray : Array<NSData>? = ud.objectForKey("fav") as? Array<NSData>
//        if favArray == nil {
//            favArray = Array<NSData>()
//        }
//        
//        if contains(favArray!, dataFav) == false{
//            var buttonImage = UIImage(named: "star.png")
//            self.favoriteBtn.setBackgroundImage(buttonImage, forState: UIControlState.Normal)
//        }else if contains(favArray!, dataFav) == true{
//            var buttonImage = UIImage(named: "star2.gif")
//            self.favoriteBtn.setBackgroundImage(buttonImage, forState: UIControlState.Normal)
//        }
//        
//        self.favoriteBtn.addTarget(self, action: "btn_click:", forControlEvents:.TouchUpInside)
        
        
        self.lm = CLLocationManager()
        self.longitude = CLLocationDegrees()
        self.latitude = CLLocationDegrees()
        
        self.lat = self.latitude as Double
        self.lon = self.longitude as Double
        
        self.lm.delegate = self
        
        lm.requestAlwaysAuthorization()
        
        lm.startUpdatingLocation()
        
        //位置情報の精度
        lm.desiredAccuracy = kCLLocationAccuracyBest
        //位置情報取得間隔(m)
        lm.distanceFilter = 300
    
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
        //お気に入りボタン
        fav.lon = self.longitude
        fav.lat = self.latitude
        fav.address = self.addressLabel.text
        
        //シリアライズ
        var dataFav : NSData = NSKeyedArchiver.archivedDataWithRootObject(fav)
        
        let ud = NSUserDefaults.standardUserDefaults()
        
        var favArray : Array<NSData>? = ud.objectForKey("fav") as? Array<NSData>
        if favArray == nil {
            favArray = Array<NSData>()
        }
        
        if contains(favArray!, dataFav) == false{
            var buttonImage = UIImage(named: "star.png")
            self.favoriteBtn.setBackgroundImage(buttonImage, forState: UIControlState.Normal)
        }else if contains(favArray!, dataFav) == true{
            var buttonImage = UIImage(named: "star2.gif")
            self.favoriteBtn.setBackgroundImage(buttonImage, forState: UIControlState.Normal)
        }
        
        self.favoriteBtn.addTarget(self, action: "btn_click:", forControlEvents:.TouchUpInside)
//        makeDate()
        var weatherMakeData = WeatherMakeData()
        weatherMakeData.lat = self.lat
        weatherMakeData.lon = self.lon
        weatherMakeData.address = self.address
        
        weatherMakeData.makeData { () -> Void in
            self.weatherLabel.text = weatherMakeData.weather
            self.maxLabel.text = weatherMakeData.max.description
            self.minLabel.text = weatherMakeData.min.description
            self.tempLabel.text = weatherMakeData.t.description
            
            var image : String = weatherMakeData.imageName
            self.myImageView.image = UIImage(named: image)
        }
        geocording()
    }
    
    //位置情報取得失敗時
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        
        println(error)
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
            self.favAddress = "\(address)"
            self.address = self.address.stringByReplacingOccurrencesOfString(", ", withString: "\n", options: nil, range: nil)
            self.address = self.address.stringByReplacingOccurrencesOfString(" ", withString: "\n", options: nil, range: nil)
            println(self.address)
            
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.addressLabel.adjustsFontSizeToFitWidth = false
                self.addressLabel.text = self.address
                self.addressLabel.sizeToFit()
                
            })
        
        })
        task.resume()
        
    }
    
    //ボタン押したら
    func btn_click(sender: UIButton){
        fav.lon = self.longitude
        fav.lat = self.latitude
        fav.address = self.addressLabel.text
        
        //シリアライズ
        var dataFav : NSData = NSKeyedArchiver.archivedDataWithRootObject(fav)
        
        let ud = NSUserDefaults.standardUserDefaults()
        
        var favArray : Array<NSData>? = ud.objectForKey("fav") as? Array<NSData>
        if favArray == nil {
            favArray = Array<NSData>()
        }
        if contains(favArray!, dataFav) == false{
            favArray!.append(dataFav)
            var buttonImage = UIImage(named: "star2.gif")
            self.favoriteBtn.setBackgroundImage(buttonImage, forState: UIControlState.Normal)
        }else if contains(favArray!, dataFav) == true{
            let i = find(favArray!, dataFav)
            favArray!.removeAtIndex(i!)
            var buttonImage = UIImage(named: "star.png")
            self.favoriteBtn.setBackgroundImage(buttonImage, forState: UIControlState.Normal)
        }

        
        ud.setObject(favArray!, forKey: "fav")
        ud.synchronize()

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
