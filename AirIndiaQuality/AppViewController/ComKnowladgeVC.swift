//
//  ComKnowladgeVC.swift
//  AirIndiaQuality
//
//  Created by Shivang Dave on 28/08/16.
//  Copyright © 2016 Shivang Dave. All rights reserved.
//

import UIKit

class ComKnowladgeVC: UIViewController {
    
    @IBOutlet weak var txtView : UITextView!
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initActivityLoader("Assets All_Loader_Oizom", LableName: "LOADING", color: true)
        
        let url = NSURLRequest(URL: NSURL(string: "http://oizom.com/knowledgecenter")!)
        webView.loadRequest(url)
        
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        activityLoader(true)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        activityLoader(false)
    }

    
    override func viewDidAppear(animated: Bool) {
        txtView.scrollRangeToVisible(NSMakeRange(0, 0))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
