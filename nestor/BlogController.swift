//
//  blogControllerViewController.swift
//  nestor
//
//  Created by milliere on 23/09/2016.
//  Copyright © 2016 milliere. All rights reserved.
//

import UIKit

class BlogController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet var ww: UIWebView!
//    var indicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.view.activityIndicatorView.startAnimating()
        
        self.ww.delegate = self
        let nav = self.navigationController?.navigationBar
        nav?.backItem?.title = "Nestor"
        
        let url = NSURL(string: "http://leblogdenestor.com/")
        let request = NSURLRequest(url: url as! URL)
        ww.loadRequest(request as URLRequest)

        // Do any additional setup after loading the view.
    }
    
//    func webViewDidStartLoad(_ webView: UIWebView) {
//        
//    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.view.activityIndicatorView.stopAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(sender : UIBarButtonItem) {
        if ww.canGoBack {
            ww.goBack()
        }
    }
    
    @IBAction func forward(sender : UIBarButtonItem) {
        if ww.canGoForward {
            ww.goForward()
        }
    }

}
