//
//  ViewController.swift
//  WebHockSample
//
//  Created by 平塚 俊輔 on 2015/04/24.
//  Copyright (c) 2015年 平塚 俊輔. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var webview: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let URL = NSURL(string: "https://calm-river-1648.herokuapp.com/")
        var urlRequest: NSURLRequest = NSURLRequest(URL: URL!)
        self.webview.loadRequest(urlRequest)
    }

    
    func webViewDidStartLoad(webView: UIWebView){
        
        
    }
    
    func webViewDidFinishLoad(webView: UIWebView){
        
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError){
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

