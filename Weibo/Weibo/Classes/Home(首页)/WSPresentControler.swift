//
//  WSPresentControler.swift
//  Weibo
//
//  Created by Ws on 16/1/9.
//  Copyright © 2016年 Ws. All rights reserved.
//

import UIKit

class WSPresentControler: UIPresentationController {

    /**
     用来设置modal处的view的尺寸
     */
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        ///有一个属性,就是modal出的控制器
        presentedView()?.frame = CGRectMake(100, 56, 200, 300)
        ///增加一个蒙版和动作,点击后执行dismiss动作
        setupHUD()
        
    }
    
    //增加一个蒙版和动作,点击后执行dismiss动作
    func setupHUD() {
        //1.创建蒙版,并设置属性
        let hudView = UIView(frame: (containerView?.bounds)!)
        hudView.backgroundColor = UIColor.clearColor()
        
        //2.增加点击手势
        let tap = UITapGestureRecognizer(target: self, action: "tapClick")
        
        //3.添加到视图中
        containerView?.insertSubview(hudView, belowSubview: presentedView()!)
        hudView.addGestureRecognizer(tap)
    }
    
    @objc private func tapClick() {
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    
    
}
