//
//  DetailViewController.swift
//  hwsproject7
//
//  Created by Enrique Florencio on 3/27/19.
//  Copyright © 2019 Enrique Florencio. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    //Create a webview for loading web pages
    var webView: WKWebView!
    //Create a property that contains our dictionary of Petition data.
    var detailItem: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //If there's something missing from detailItem then return, otherwise unwrap into itself
        guard let detailItem = detailItem else {return}
        
        //Create the layout of the body with html
        let html = """
        <html>
        <head>
        <meta name = "viewport" content = "width=device-width", initial-scale=1">
        <style> body { font-size: 150%;} </style>
        </head>
        <body>
        \(detailItem.body)
        </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
        
    }
    

    

}
