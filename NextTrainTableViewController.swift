//
//  NextTrainTableViewController.swift
//  ex6
//
//  Created by HARUKA on 7/15/15.
//  Copyright (c) 2015 HARUKA. All rights reserved.
//

import UIKit

class NextTrainTableViewController: UITableViewController {
    
    @IBOutlet weak var stationLine: UINavigationItem!
    @IBOutlet var myTableView: UITableView!
    var line : String?
    var array = Array<NSDictionary>()
    var urlString : String?
    var stationName : String?
    var selectedStation : String?
    var stationX : Int?
    var selectedX : Int?
    var stationY : Int?
    var selectedY : Int?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        stationLine.title = line

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let manager = AFHTTPRequestOperationManager()
        
        let urlstring1 = "http://express.heartrails.com/api/json?method=getStations&line="
        let urlstring2 = "\(line!)"
        self.urlString = urlstring1 + urlstring2.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        println(self.urlString!)
        
        manager.GET(self.urlString!, parameters: nil,
            success: {(operation: AFHTTPRequestOperation!, responsobject: AnyObject!) in
                println("success!!")
                println(responsobject)
                
                let dic : NSDictionary = responsobject as! NSDictionary
                
                self.array = dic.objectForKey("response")?.objectForKey("station") as! Array
                
                
                println(self.array)
                
                self.myTableView.reloadData()
                
            },
            failure: {(operation: AFHTTPRequestOperation!, error: NSError!) in
                println("Error!!")
                println(self.urlString!)
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.array.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")

        // Configure the cell...
        let station : NSDictionary = self.array[indexPath.row]
        self.stationName = station.objectForKey("name") as? String
        self.stationX = station.objectForKey("x") as? Int
        self.stationY = station.objectForKey("y") as? Int

        cell.textLabel?.text = stationName

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // indexPathから選択された駅をself.arrayから取得する
        
        // 取得した駅を選択した駅に代入
        
        // 次の画面へ遷移する
        
        selectedStation = self.array[indexPath.row].objectForKey("name") as? String
        self.selectedX = self.array[indexPath.row].objectForKey("x") as? Int
        self.selectedY = self.array[indexPath.row].objectForKey("y") as? Int
        performSegueWithIdentifier("toWeatherViewController", sender: nil)
    }

    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if (segue.identifier == "toWeatherViewController"){
            let weatherViewController : WeatherViewController = segue.destinationViewController as! WeatherViewController
            
            weatherViewController.line = selectedStation
            weatherViewController.x = selectedX
            weatherViewController.y = selectedY
            println(self.line!)
            println(self.selectedStation!)
        }

    }
    

}
