//
//  FavoriteTableViewController.swift
//  ex6
//
//  Created by HARUKA on 8/19/15.
//  Copyright (c) 2015 HARUKA. All rights reserved.
//

import UIKit

class FavoriteTableViewController: UITableViewController {
    
    var lat : Double!
    var lon : Double!
    var address :  String!
    
    var selectedAddress : String!
    var selectedLon : Double!
    var selectedLat : Double!
    
    var datas : Array<WeatherFav> = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ud = NSUserDefaults.standardUserDefaults()
        
        let favArray : Array<NSData>? = ud.objectForKey("fav") as? Array<NSData>
        
        if let favArrayUnwrapp : Array<NSData> = favArray {
            for data in favArrayUnwrapp {
                let fav : WeatherFav = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! WeatherFav
                self.datas.append(fav)
            }
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return self.datas.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")

        // Configure the cell...
        cell.textLabel?.text = datas[indexPath.row].address

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.selectedAddress = datas[indexPath.row].address
        self.selectedLat = datas[indexPath.row].lat
        self.selectedLon = datas[indexPath.row].lon
        print(self.selectedLat)
        print(self.selectedLon)
        print(self.selectedAddress)
        performSegueWithIdentifier("toFavoriteViewController", sender: nil)
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "toFavoriteViewController"){
            let favoriteViewController : FavoriteViewController = segue.destinationViewController as! FavoriteViewController
            
            favoriteViewController.address = self.selectedAddress
            favoriteViewController.lat = self.selectedLat
            favoriteViewController.lon = self.selectedLon

            
        }
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            self.datas.removeAtIndex(indexPath.row)
            
            let ud = NSUserDefaults.standardUserDefaults()
            var favArray : Array<NSData>? = ud.objectForKey("fav") as? Array<NSData>
            if favArray == nil {
                favArray = Array<NSData>()
            }
            favArray!.removeAtIndex(indexPath.row)
            
            ud.setObject(favArray!, forKey: "fav")
            ud.synchronize()
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
