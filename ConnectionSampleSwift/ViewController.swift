//
//  ViewController.swift
//  ConnectionSampleSwift
//
//  Created by 平塚 俊輔 on 2015/04/20.
//  Copyright (c) 2015年 平塚 俊輔. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var connectionsession : ConnectionBySession!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        connectionsession = ConnectionBySession()
        connectionsession.delegate = self
        connectionsession.doConncet("http://dev.swallow.cu01.shotlabo.info/sw/app/work?output=json&start=1&key_api=key_001&results=20&prefcode=13&a=03&apliflag=1")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension  ViewController:ConnectionBySessionResult {
    
    
    // delegate
    // 実際に処理を行う
    func showResult() -> Void {
        
        var error: NSError?
        println(connectionsession)
        println(connectionsession.connectedData)
        
        
        if let dict = NSJSONSerialization.JSONObjectWithData(connectionsession.connectedData!, options:NSJSONReadingOptions.AllowFragments , error: &error) as? NSDictionary{
            
            //get responseData, feed, entries
            var responseData = dict["ResultSet"] as! NSDictionary
            println(responseData)
            
            
        }else{
            println("error parsing json")
            println(error)
            handleError()
            return
        }
        
    }
    
    func handleErrorForConnection(){
        handleError()
    }
    
    func handleError(){
        
    }
    
    
    
    
    
    
}


