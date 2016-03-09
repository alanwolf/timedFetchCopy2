//
//  ViewController.swift
//  Timed Fetch
//
//  Created by Alan Wolf on 3/4/16.
//  Copyright © 2016 Wolf Cottage, LLC. All rights reserved.
//

import UIKit
    var lat:Double = 0.0
    var lon:Double = 0.0

class ViewController: UIViewController {
    var timer = NSTimer()
    var myCounter = 0
    
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lonLabel: UILabel!
    @IBOutlet weak var myLabel: UILabel!
    
    
    func incrementCounter(myTimer:NSTimer){
     
        dispatch_async(dispatch_get_main_queue()) {
        let api = LocationServerApi()
        api.getServerData(nil)
        self.myCounter = self.myCounter + 1
        
        print ("Latitude: ",lat)
        print ("Longitude: ",lon)
        print("\r\n")
            
        self.myLabel.text = String(self.myCounter)
        self.latLabel.text = String(lat)
        self.lonLabel.text = String(lon)
            
            
     }
        
        
    }
    
    @IBAction func startFetching(sender: AnyObject) {
        
        if timer.valid == false {
            
            timer = NSTimer.scheduledTimerWithTimeInterval (0.5, target: self, selector: ("incrementCounter:"), userInfo: nil, repeats: true)
            print ("timer is on")
            print(myCounter)
        }
    }
    
    @IBAction func stopFetching(sender: AnyObject) {
        
        if timer.valid == true{
            timer.invalidate()
            print(myCounter)
            print ("timer is off")
        }
        
    }
    
    @IBAction func reset(sender: AnyObject) {
        
        myCounter = 0
        myLabel.text = String(myCounter)
        self.latLabel.text = String(0)
        self.lonLabel.text = String(0)
        print(myCounter)
        print("timer reset")
    }
    
    class LocationServerApi {
        func getServerData (completion:((AnyObject)->Void)!) {
            let urlString = "https://wanderdrone.appspot.com"
            let session = NSURLSession.sharedSession()
            let locationUrl = NSURL(string: urlString)
            
            let task = session.dataTaskWithURL(locationUrl!) {
                (data, response, error) -> Void in
                if error != nil {
                    print(error!.localizedDescription)
                } else {
                    do {
                        if let jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                            //print (jsonResult)
                            let geometry = jsonResult["geometry"] as! NSDictionary
                            let coordinates = geometry["coordinates"] as! NSArray
                            lat = coordinates[0] as! Double
                            lon = coordinates[1] as! Double
                        }
                        
                    } catch let error as NSError {
                        print("Error:\n \(error)")
                        return
                    }
                }
            }
            task.resume()
        }
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

