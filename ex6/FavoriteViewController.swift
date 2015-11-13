//
//  FavoriteViewController.swift
//  ex6
//
//  Created by HARUKA on 8/12/15.
//  Copyright (c) 2015 HARUKA. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var titleNavigationItem: UINavigationItem!
    
    var lat : Double!
    var lon : Double!
    var address : String!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let weatherMakeData = WeatherMakeData()
        weatherMakeData.lat = self.lat
        weatherMakeData.lon = self.lon
        weatherMakeData.address = self.address
        
        weatherMakeData.makeData { () -> Void in
            self.weatherLabel.text = weatherMakeData.weather
            self.maxLabel.text = weatherMakeData.max.description
            self.minLabel.text = weatherMakeData.min.description
            self.tempLabel.text = weatherMakeData.t.description
            
            let image : String = weatherMakeData.imageName
            self.myImageView.image = UIImage(named: image)
        }
        
        
        
//        self.maxLabel.text = weatherMakeData.max!.description
        
       
        
        // Do any additional setup after loading the view.
        titleNavigationItem.title = self.address
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
