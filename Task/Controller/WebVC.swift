//
//  WebVC.swift
//  Task
//
//  Created by Eslam Elshaht on 1/25/21.
//

import UIKit
import WebKit

class WebVC: UIViewController,WKNavigationDelegate {
    @IBOutlet weak var webView: WKWebView!
    
    var webVIew: WKWebView!

    
    override func loadView() {
        webVIew = WKWebView()
        webVIew.navigationDelegate = self
        view = webVIew
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://google.com")!
        webVIew.load(URLRequest(url: url))
        webVIew.allowsBackForwardNavigationGestures = true

    }
    
}
