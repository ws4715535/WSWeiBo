//
//  OAuthController.swift
//  Weibo
//
//  Created by Ws on 16/1/11.
//  Copyright © 2016年 Ws. All rights reserved.
//

import UIKit

class OAuthController: UIViewController {

    
    @IBOutlet weak var webView: UIWebView!
    
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        // 初始化函数
        setupInit()
        
        // 网络请求加载网页
        loadWebPage()
    }
    // MARK:- 一些初始化操作
    private func setupInit() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .Done, target: self, action: "closeClick")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: .Done, target: self, action: "fillIn")
    }
    
    private func loadWebPage() {
        //1.url路径
        let urlStr = "https://api.weibo.com/oauth2/authorize?client_id=\(app_key)&redirect_uri=\(redirect_uri)"
        //2.url
        guard let url = NSURL(string: urlStr) else {
            print("url error")
            return
        }
        
        //3.加载Request
        let request = NSURLRequest(URL: url)
        webView.loadRequest(request)
    }
    
    
    
    // MARK:- 监听按钮点击事件
    @objc private func closeClick() {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @objc private func fillIn() {
        // 1.写js代码
        let jsCode = "document.getElementById('userId').value='1606020376@qq.com';document.getElementById('passwd').value='haomage';"
        
        // 2.执行js
        webView.stringByEvaluatingJavaScriptFromString(jsCode)
        
        
    }

    
}
