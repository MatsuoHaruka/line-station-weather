//
//  CellViewController.swift
//  ex6
//
//  Created by HARUKA on 7/1/15.
//  Copyright (c) 2015 HARUKA. All rights reserved.
//

import UIKit

class CellViewController: UIViewController {
    
    @IBOutlet weak var wetherLabel: UILabel!
    var wetherDes : String?
    @IBOutlet weak var myLabel: UILabel!
    var info : String?
    var wether : NSObject?
    var tempreture : String?
   
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var myImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.myLabel.text = info
//        println(wether)
        
        self.wetherLabel.text = wetherDes
        var per = "℃"
        self.tempLabel.text = tempreture! + per
        if wether == "Rain"{
            self.myImageView.image = UIImage(named: "rain.png")
        }else if wether == "Clouds"{
            self.myImageView.image = UIImage(named: "clouds.png")
        }else if wether == "Clear"{
            self.myImageView.image = UIImage(named: "clear.png")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


