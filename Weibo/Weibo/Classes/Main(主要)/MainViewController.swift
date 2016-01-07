//
//  MainViewController.swift
//  Weibo
//
//  Created by Ws on 16/1/7.
//  Copyright © 2016年 Ws. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    // MARK:- 懒加载数组
    lazy var imageNames :[String] = {
        
        return ["tabbar_home","tabbar_message_center","","tabbar_discover","tabbar_profile"]
    }()
    
    // MARK:- 懒加载按钮
    lazy var composeBtn : UIButton = {
       let composeBtn = UIButton(image: "tabbar_compose_icon_add", bgImage: "tabbar_compose_button")
        
        
        // MARK:- 设置按钮的位置
        composeBtn.center = CGPoint(x: self.tabBar.center.x, y: self.tabBar.bounds.size.height * 0.5)
        
        // MARK:- 监听按钮点击事件
            //不同于oc Selector的写法有两种:
            // 第一种写法:Selector("方法的名称")
            // 第二种写法:"方法的名称"
        composeBtn.addTarget(self, action: "composeBtnClick", forControlEvents: .TouchUpInside)
        
        return composeBtn
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.addSubview(composeBtn)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //这里调整按钮
            //1.按钮的图片 2.items的相关 3.让第二个按钮不能点击
        //执行函数
        adjustItems()
    }
    
    // MARK:- 监听点击事件
    // 将函数修饰成private就不会将函数添加到方法列表中
    // 在private加载@objc,就会将该方法添加到方法列表中
    /// 监听中间按钮的点击
    @objc private func composeBtnClick() {
        print("点击了按钮")
    }
    
    // MARK:- 自定义函数设置barItem
    private func adjustItems() {
        for i in 0..<tabBar.items!.count {
            //便利各个items
            let item = tabBar.items![i]
            //让加号按钮失效
            if i == 2 {
                item.enabled = false
            }
            
            //设置各个按钮图片
            item.image = UIImage(named: imageNames[i])
            item.selectedImage = UIImage(named: imageNames[i] + "_highlighted")
        }
  
    }
    
    
    

}
