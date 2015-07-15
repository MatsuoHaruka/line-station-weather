//
//  weatherCell.swift
//  ex6
//
//  Created by HARUKA on 7/2/15.
//  Copyright (c) 2015 HARUKA. All rights reserved.
//

import UIKit

class weatherCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func resetCell(){
        self.dateLabel.text = ""
        self.tempLabel.text = ""
        self.weatherImageView.image = nil
    }
    
    func setWeatherWithDate(date: String,temp: String,weatherImage: UIImage){
        
        self.dateLabel.text = date
        self.tempLabel.text = temp
        self.weatherImageView.image = weatherImage
    }
    

}
