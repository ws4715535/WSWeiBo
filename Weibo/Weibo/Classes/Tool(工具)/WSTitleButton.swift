//
//  WSTitleButton.swift
//  Weibo
//
//  Created by Ws on 16/1/8.
//  Copyright © 2016年 Ws. All rights reserved.
//

import UIKit

class WSTitleButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //设置按钮样式
        setTitle("WS的微博", forState: .Normal)
        setTitleColor(UIColor.blackColor(), forState: .Normal)
        setImage(UIImage(named: "navigationbar_arrow_down"), forState: .Normal)
        setImage(UIImage(named: "navigationbar_arrow_up"), forState: .Selected)
        
        sizeToFit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

        // MARK:- 设置子控件位置
    override func layoutSubviews() {
        super.layoutSubviews()
        //swift中可以直接修改结构体中的属性
        imageView?.center.x = (titleLabel?.bounds.size.width)! + (titleLabel?.bounds.origin.x)!
        //中间存放他们有个父控件,所以为0就是最左边
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = titleLabel!.frame.size.width + 5
        
        
    }
}
