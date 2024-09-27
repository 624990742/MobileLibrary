//
//  MLWebController.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/4/3.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import Foundation
import WebKit

enum MLProtocolHtml {
    case user
    case yinsi
}

class MLWebController:MLBaseController {
    var htmltype:MLProtocolHtml = .user
    var urlStr :String?

    lazy var webView: WKWebView = {
        let web = WKWebView()
        web.uiDelegate = self
        web.navigationDelegate = self
        view.addSubview(web)
        return web
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = UIColor.white
        
        self.view.addSubview(self.webView)
        self.webView.snp.makeConstraints { make in
            make.top.equalTo(self.gk_navigationBar.snp.bottom)
            make.left.right.bottom.equalTo(self.view)
        }
        let htmlFile = self.htmltype == .user ? "privacy_user" : "privacy_policy"
        self.gk_navTitle = self.htmltype == .user ? "用户服务协议" : "隐私协议"
        if let url = Bundle.main.url(forResource: htmlFile, withExtension: "html") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
          
    }
    
    
}

extension MLWebController : WKUIDelegate,WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }

}

