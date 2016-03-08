//
//  ViewController.swift
//  Timed Fetch
//
//  Created by Alan Wolf on 3/4/16.
//  Copyright © 2016 Wolf Cottage, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer = NSTimer()
    var myCounter = 0
    
    
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lonLabel: UILabel!
    @IBOutlet weak var myLabel: UILabel!
    func incrementCounter(myTimer:NSTimer){
     
        myCounter = myCounter + 1
        myLabel.text = String(myCounter)
        
        
        
        
    }
    
    @IBAction func startFetching(sender: AnyObject) {
        
        if timer.valid == false {
            
            timer = NSTimer.scheduledTimerWithTimeInterval (0.1, target: self, selector: ("incrementCounter:"), userInfo: nil, repeats: true)
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
        print(myCounter)
        print("timer reset")
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

