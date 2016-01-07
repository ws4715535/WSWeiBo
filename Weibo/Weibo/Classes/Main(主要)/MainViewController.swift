//
//  MainViewController.swift
//  Weibo
//
//  Created by Ws on 16/1/7.
//  Copyright © 2016年 Ws. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.redColor()
        setUpChildControllers(HomeViewController(), title: "首页", image: "tabbar_home")
        setUpChildControllers(MessageViewController(), title: "消息", image: "tabbar_message_center")
        setUpChildControllers(DiscoverViewController(), title: "发现", image: "tabbar_discover")
        setUpChildControllers(ProfoleViewController(), title: "首页", image: "tabbar_profile")
    }
    func setUpChildControllers(childController : UIViewController , title : String , image : String) {
        //1.创建子控制器
        let naviController = UINavigationController(rootViewController: childController)
        
        //2.设置标题和图片
        naviController.title = title
        naviController.tabBarItem.image = UIImage(named: image)
        naviController.tabBarItem.selectedImage = UIImage(named: image + "_highlighted")
        
        //3.添加到MainController
        addChildViewController(naviController)

    }
    

}
