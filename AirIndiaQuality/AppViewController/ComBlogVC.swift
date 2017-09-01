//
//  ComBlogVC.swift
//  AirIndiaQuality
//
//  Created by Shivang Dave on 28/08/16.
//  Copyright © 2016 Shivang Dave. All rights reserved.
//

import UIKit

class ComBlogVC: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView : UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        initActivityLoader("Assets All_Loader_Oizom", LableName: "LOADING", color: true)
        
        let url = NSURLRequest(URL: NSURL(string: "http://blog.oizom.com")!)
        webView.loadRequest(url)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        activityLoader(true)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        activityLoader(false)
    }

}
