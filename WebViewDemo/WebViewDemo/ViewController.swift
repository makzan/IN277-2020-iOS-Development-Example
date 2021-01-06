//
//  ViewController.swift
//  WebViewDemo
//
//  Created by in200-06-2018-cm on 12/07/2018.
//  Copyright © 2018 in200-06-2018-cm. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var stackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // Setup Navigation Item
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(tappedShareButton))
        
        
        
        // Setup webview
        
        // Session
        let configuration = WKWebViewConfiguration()
        configuration.processPool = GlobalSession.shared.processPool
        
        // Message handler
        let userContentController = WKUserContentController()
        
        // the name has to match the JavaScript part.
        userContentController.add(self, name: "notification")
        
        configuration.userContentController = userContentController
        
        // Init the webview
        let webview = WKWebView.init(frame: .zero, configuration: configuration)
        webview.customUserAgent = "Demo App iOS, version 1.0 build 2020.12"
        
        
        // Finally, we load the URL
        webview.load(URLRequest(url: URL(string: "https://in200-demo.netlify.com/app.html")!))
        
        
        
        webview.navigationDelegate = self
        
        
        // Make sure we add the new web view into the view hierarchy.
        stackView.addArrangedSubview(webview)
        
        
        
    }
    
    @objc func tappedShareButton() {
        let urlString = "https://in200-demo.netlify.com/app.html"
        let url = URL(string: urlString)
        let vc = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
        
        self.present(vc, animated: true)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let name = "Thomas Mak"
        let tel = "28123123"
        let mobileTel = "66661234"
        let script = "fillInForm('" + name + "', '" + tel + "', '" + mobileTel + "')"
        webView.evaluateJavaScript(script)
        
        // OR:
        
        webView.evaluateJavaScript(script) { (returnedResult, error) in
            print("Returned: ")
            print(returnedResult)
        }
        
        print(UIApplication.shared.preferredContentSizeCategory.rawValue )
        webView.evaluateJavaScript("setAccessibilityFontSize('" + UIApplication.shared.preferredContentSizeCategory.rawValue + "')")
    }


}


extension ViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("HERE with message from JavaScript")
        print(message.name)
        print(message.body)
    }
}







