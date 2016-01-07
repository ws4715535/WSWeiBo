//
//  UIButton+SetImage.swift
//  Weibo
//
//  Created by Ws on 16/1/8.
//  Copyright © 2016年 Ws. All rights reserved.
//

import UIKit

extension UIButton {
    
    //便利构造函数
    convenience init (image : String, bgImage : String) {
        self.init()
        
        //设置按钮图片
        setImage(UIImage(named: image), forState: .Normal)
        setImage(UIImage(named: image + "_highlighted"), forState: .Highlighted)
        //设置背景图片
        setBackgroundImage(UIImage(named: bgImage), forState: .Normal)
        setBackgroundImage(UIImage(named: bgImage + "_highlighted"), forState: .Highlighted)
        
        //2.设置按钮尺寸
        sizeToFit()
    }
    
    
    
    
    
}