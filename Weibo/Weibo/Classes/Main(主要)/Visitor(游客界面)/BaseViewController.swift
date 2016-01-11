//
//  BaseViewController.swift
//  Weibo
//
//  Created by Ws on 16/1/8.
//  Copyright © 2016年 Ws. All rights reserved.
//

import UIKit

class BaseViewController: UITableViewController {

    // MARK:- 属性
    var visitorView :VisitorView?
    
    
    ///是否登录
    var isLogin = false
    // MARK:- 系统回调函数
    override func loadView() {
        isLogin ? super.loadView() : setupVisitorView()
    }
    
    // MARK:- 自定义访客模式
    private func setupVisitorView() {
        
        
        let visitorView = VisitorView.visitor()
        
        //监听view视图中按钮的点击
        visitorView.registBtn.addTarget(self, action: "registBtnClick", forControlEvents: .TouchUpInside)
        visitorView.loginBtn.addTarget(self, action: "loginBtnClick", forControlEvents: .TouchUpInside)
        
        //设置NavigationItem
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .Done, target: self, action: "registBtnClick")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .Done, target: self, action: "loginBtnClick")
        
        //设置访问视图
        self.visitorView = visitorView
        view = visitorView
    }
    // MARK:- 不同界面不同的icon给外的接口
    func setupVisitorInfo(iconImageName : String , text : String) {
        visitorView?.iconImageV.image = UIImage(named:iconImageName)
        visitorView?.textLabel.text = text
        //隐藏旋转view
        visitorView?.rotateImageV.hidden = true
    }
 
    // MARK:- 监听点击的方法
    @objc private func registBtnClick() {
        print("注册按钮")
    }
    @objc private func loginBtnClick() {
        
        
        let oauth = OAuthController()
        let navi = UINavigationController(rootViewController: oauth)
        presentViewController(navi, animated: true, completion: nil)
        
    }
    
    // MARK:- 增加旋转动画
    func startAnimation() {
        //1.创建基本动画
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        
        //2.设置动画内容
        rotationAnim.fromValue = 0
        rotationAnim.toValue = M_PI * 2
        rotationAnim.duration = 10.0
        rotationAnim.repeatCount = MAXFLOAT
        
        //3.当返回界面时不取消旋转
        rotationAnim.removedOnCompletion = false
        
        
        //4.给rotateImageV增加旋转动画
        visitorView?.rotateImageV.layer.addAnimation(rotationAnim, forKey: nil)
    }

}
