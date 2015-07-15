//
//  ViewController.swift
//  ex6
//
//  Created by HARUKA on 7/1/15.
//  Copyright (c) 2015 HARUKA. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
  
    @IBOutlet weak var tableView: UITableView!
      
    var jsoncount : Int?
    
    var cellItems = NSMutableArray()
    var selectedRow :String?
    var refreshControl : UIRefreshControl!
    var wether = NSMutableArray()
    var wetherDes = NSMutableArray()
    var tempreture = NSMutableArray()
    var date = NSMutableArray()
    var selectedNum : Int?
    
    let urlString = "http://api.openweathermap.org/data/2.5/forecast?units=metric&q=Tokyo"
    
    
    
//    makeDate
    func makeDate(){
        var url = NSURL(string: self.urlString)!
        var task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {data, response, error in
            var json = JSON(data: data)
            self.jsoncount = json["list"].count
            println(self.jsoncount!)
            for var i = 0; i < self.jsoncount; i++ {
            var dt_txt = json["list"][i]["dt_txt"]
            var weatherMain = json["list"][i]["weather"][0]["main"]
            var weatherDescription = json["list"][i]["weather"][0]["description"]
            var temp = json["list"][i]["main"]["temp"]
            
            var info = "\(dt_txt), \(weatherMain), \(weatherDescription)"
            
            self.cellItems[i] = info
            self.wether[i] = "\(weatherMain)"
            self.wetherDes[i] = "\(weatherDescription)"
            self.tempreture[i] = "\(temp)"
            self.date[i] = "\(dt_txt)"
                
            }
            
            println("task end")
//            println(self.wether)
            self.refreshControl?.endRefreshing()

            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
                })
            
        })
        
        task.resume()
        println("makeDate end")
        
        
        }
    
    func pullToRefresh(){
        makeDate()
        self.tableView.reloadData()
        
    }
    
//    tableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        let cell : weatherCell = tableView.dequeueReusableCellWithIdentifier("weatherCell", forIndexPath: indexPath) as! weatherCell
        
        let weatherImage : UIImage
        
        if self.wether[indexPath.row] as? String == "Rain"{
            weatherImage = UIImage(named: "rain.png")!
        }else if self.wether[indexPath.row] as? String == "Clouds"{
            weatherImage = UIImage(named: "clouds.png")!
        }else if self.wether[indexPath.row] as? String == "Clear"{
            weatherImage = UIImage(named: "clear.png")!
        }else{
            weatherImage = UIImage(named: "clear.png")!
        }
        
//        cell.textLabel?.text = (self.cellItems[indexPath.row] as! String)
        cell.resetCell()
        cell.setWeatherWithDate(self.date[indexPath.row] as! String, temp: self.tempreture[indexPath.row] as! String, weatherImage: weatherImage)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedRow = (self.cellItems[indexPath.row] as! String)
        self.selectedNum = indexPath.row

        performSegueWithIdentifier("toCellViewController", sender: nil)
        
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        makeDate()
        
        var refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "Loading...")
        refresh.addTarget(self, action: "pullToRefresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refresh)
        self.refreshControl = refresh

    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let indexPath : NSIndexPath? = self.tableView?.indexPathForSelectedRow()
        if indexPath != nil {
            self.tableView?.deselectRowAtIndexPath(indexPath!, animated: true)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - segue methods
    // セグエです
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toCellViewController"){
            let cellViewController : CellViewController = segue.destinationViewController as! CellViewController

//            cellViewController.info = selectedRow
            cellViewController.info = self.date[selectedNum!] as? String
            cellViewController.wether = self.wether[selectedNum!] as? NSObject
            cellViewController.wetherDes = self.wetherDes[selectedNum!] as? String
            cellViewController.tempreture = self.tempreture[selectedNum!] as? String
        }
    }
    


}

