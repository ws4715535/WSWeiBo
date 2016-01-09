//
//  VisitorView.swift
//  Weibo
//
//  Created by Ws on 16/1/8.
//  Copyright © 2016年 Ws. All rights reserved.
//

import UIKit

class VisitorView: UIView {
    // MARK:- 属性
    
    @IBOutlet weak var rotateImageV: UIImageView!
    
    @IBOutlet weak var iconImageV: UIImageView!
    
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var registBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    // MARK:- 从xib加载view
    class func visitor () ->VisitorView {
       return NSBundle.mainBundle().loadNibNamed("VisitorView", owner: nil, options: nil).last as!VisitorView
    }

}
