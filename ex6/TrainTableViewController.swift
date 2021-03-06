//
//  TrainTableViewController.swift
//  ex6
//
//  Created by HARUKA on 7/15/15.
//  Copyright (c) 2015 HARUKA. All rights reserved.
//

import UIKit
import SwiftyJSON
import AFNetworking

class TrainTableViewController: UITableViewController {
    
    @IBOutlet var myTableView: UITableView!
    var array = Array<String>()
    var selectedline : String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        let manager = AFHTTPRequestOperationManager()
        
        manager.GET("http://express.heartrails.com/api/json?method=getLines&area=%E9%96%A2%E6%9D%B1", parameters: nil,
            success: {(operation: AFHTTPRequestOperation!, responsobject: AnyObject!) in
                print("success!!")
                
                let dic : NSDictionary = responsobject as! NSDictionary
                
                self.array = dic.objectForKey("response")?.objectForKey("line") as! Array
                
                self.myTableView.reloadData()
                
            },
            failure: {(operation: AFHTTPRequestOperation!, error: NSError!) in
                print("Error!!")})

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
        print(self.array.count)
        return self.array.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        // Configure the cell...
        cell.textLabel?.text = self.array[indexPath.row]

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedline = array[indexPath.row]
        performSegueWithIdentifier("toNextTrainViewController", sender: nil)
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
        if (segue.identifier == "toNextTrainViewController"){
            let nextTrainTableViewController : NextTrainTableViewController = segue.destinationViewController as! NextTrainTableViewController
            
            nextTrainTableViewController.line = selectedline
        }
    
    }
}
