//
//  WeatherViewController.swift
//  ex6
//
//  Created by HARUKA on 7/22/15.
//  Copyright (c) 2015 HARUKA. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var favoriteBtn: UIButton!
    
    @IBOutlet weak var station: UINavigationItem!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var watherLabel: UILabel!
    
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    var line :String?
    var x : Double?
    var y : Double?
    var urlString : String? = nil
    
    var weather : String?
    var temp : String?
    var temp_max : String?
    var temp_min : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        makeDate()
        
        var weatherMakeData = WeatherMakeData()
        weatherMakeData.lat = self.y
        weatherMakeData.lon = self.x
        weatherMakeData.address = self.line
        
        weatherMakeData.makeData { () -> Void in
            self.watherLabel.text = weatherMakeData.weather
            self.maxLabel.text = weatherMakeData.max.description
            self.minLabel.text = weatherMakeData.min.description
            self.tempLabel.text = weatherMakeData.t.description
            
            var image : String = weatherMakeData.imageName
            self.myImageView.image = UIImage(named: image)
        }

        
        station.title = self.line

        // Do any additional setup after loading the view.
        
        //お気に入りボタン
        var buttonImage = UIImage(named: "star.jpg")
        self.favoriteBtn.setBackgroundImage(buttonImage, forState: UIControlState.Normal)
        self.favoriteBtn.addTarget(self, action: "btn_click:", forControlEvents:.TouchUpInside)
        
    }

     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //ボタン押したら
    func btn_click(sender: UIButton){
        var fav = WeatherFav()
        
        fav.lon = self.x
        fav.lat = self.y
        fav.address = self.line
        
        //シリアライズ
        var dataFav : NSData = NSKeyedArchiver.archivedDataWithRootObject(fav)
        
        let ud = NSUserDefaults.standardUserDefaults()
        
        var favArray : Array<NSData>? = ud.objectForKey("fav") as? Array<NSData>
        if favArray == nil {
            favArray = Array<NSData>()
        }
        favArray!.append(dataFav)
        
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
