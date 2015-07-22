//
//  WeatherViewController.swift
//  ex6
//
//  Created by HARUKA on 7/22/15.
//  Copyright (c) 2015 HARUKA. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var station: UINavigationItem!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var watherLabel: UILabel!
    
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    var line :String?
    var x : Int?
    var y : Int?
    var urlString : String? = nil
    
    var weather : String?
    var temp : String?
    var temp_max : String?
    var temp_min : String?
    
    func roadView(){
        
        if self.weather == "Rain"{
            self.myImageView.image = UIImage(named:"rain.png")
        }else if self.weather == "Clouds"{
            self.myImageView.image = UIImage(named:"clouds.png")
        }else if self.weather == "Clear"{
            self.myImageView.image = UIImage(named:"clear.png")
        }
        println(self.temp!)
        println(self.weather!)
        
        var tempDouble = atof(self.temp!)
        var t = tempDouble - 273
        var maxDouble = atof(self.temp_max!)
        var max = maxDouble - 273
        var minDouble = atof(self.temp_min!)
        var min = minDouble - 273
        self.tempLabel.text = String("\(t)")
        self.maxLabel.text = String("\(max)")
        self.minLabel.text = String("\(min)")
        self.watherLabel.text = self.weather!
        

    }
    
    //   MARK: makeDate
    func makeDate(){
        let urlString1 = "http://api.openweathermap.org/data/2.5/weather?lat="
        let urlString2 = "&lon="
        var stringX = x?.description
        var stringY = y?.description
        self.urlString = urlString1 + stringY! + urlString2 + stringX!
        
        
        var url = NSURL(string: self.urlString!)
        var task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: {data, response, error in
            var json = JSON(data: data)
            
            
            var weather = json["weather"][0]["main"]
            self.weather = "\(weather)"
            
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
            
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
           
            })
            
        
        
        task.resume()
        println("makeDate end")
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeDate()
        
        station.title = self.line

        // Do any additional setup after loading the view.
        
    }

     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
