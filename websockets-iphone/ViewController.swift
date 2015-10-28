//
//  ViewController.swift
//  websockets-iphone
//
//  Created by Jan Willem Raats on 28/10/15.
//  Copyright © 2015 Jan Willem Raats. All rights reserved.
//

import UIKit
import SwiftWebSocket

class ViewController: UIViewController {
    var orientation: String!
    let ws = WebSocket("wss://www.senzingyou.nl:1337")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "sendRotated", name: UIDeviceOrientationDidChangeNotification, object: nil)
        self.startUpSockets()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func sendRotated(){
        if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation))
        {
            self.orientation = "landscape"
            self.ws.send(self.orientation)
        }
        if(UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation))
        {
           self.orientation = "portrait"
           self.ws.send(self.orientation)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startUpSockets(){
        self.ws.event.open = {
            self.view.backgroundColor = UIColor.orangeColor()
        }
        self.ws.event.close = { code, reason, clean in
            self.view.backgroundColor = UIColor.orangeColor()
        }
        self.ws.event.error = { error in
            self.view.backgroundColor = UIColor.orangeColor()
        }
        self.ws.event.message = { message in
            if let text = message as? String {
                if text == "isGreen: 'true'" {
                    self.view.backgroundColor = UIColor.greenColor()
                }
                else if text == "isGreen: 'false'"{
                    self.view.backgroundColor = UIColor.redColor()
                }
            }else{
                self.view.backgroundColor = UIColor.orangeColor()
            }
        }
    }

}

