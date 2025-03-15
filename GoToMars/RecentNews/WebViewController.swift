//
//  WebViewController.swift
//  GoToMars
//
//  Created by youngkyun park on 3/15/25.
//

import UIKit

import WebKit
import SnapKit

class WebViewController: UIViewController {
    
    private let web = WKWebView()
    private let activityIndicator = UIActivityIndicatorView()
    
    var url: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        web.navigationDelegate = self
        
        layout()
        loadWebPage(url)
        activityIndicator.startAnimating()
        
    }
    
    private func loadWebPage(_ url: String) {
        
        let url = URL(string: url)
        let urlToRequest = URLRequest(url: url!)
        web.load(urlToRequest)
        
    }
    
    
    private func layout() {
        view.addSubview(web)
        view.addSubview(activityIndicator)
        
        web.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }




}

extension WebViewController: WKNavigationDelegate {
    
    //로딩 완료
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: any Error) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
}
