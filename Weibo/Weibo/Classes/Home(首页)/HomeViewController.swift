//
//  HomeViewController.swift
//  Weibo
//
//  Created by Ws on 16/1/7.
//  Copyright © 2016年 Ws. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    var titleButton = WSTitleButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //增加转盘动画
        startAnimation()
        
        //如果没登陆
        if !isLogin {
            return
        }
        //设置导航栏相关
        setupNavigationItem()
        
    }
    
    // MARK:- 设置导航栏
    private func setupNavigationItem() {
        //设置左右button
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIButton(imageName: "navigationbar_friendattention", target:self, action: "friendBtnClick"))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: UIButton(imageName: "navigationbar_pop", target:self, action: "popBtnClick"))
        
        
        //设置中间按钮视图
        let centerBtn = WSTitleButton()
        navigationItem.titleView = centerBtn
        centerBtn.addTarget(self, action: "centerBtnClick:", forControlEvents: .TouchUpInside)
        
        
        self.titleButton = centerBtn
    }
    
    // MARK:- 设置监听按钮点击方法
    @objc private func friendBtnClick() {
        print("friendBtnClick")
    }
    
    
    
    
    // MARK:- 唤出二维码扫描界面
    @objc private func popBtnClick() {
        let storyBoard = UIStoryboard(name: "QRCodeViewController", bundle: nil)
        let qrcodeVc = storyBoard.instantiateInitialViewController()!
        qrcodeVc.modalTransitionStyle = .CrossDissolve
        presentViewController(qrcodeVc, animated: true, completion: nil)
    
    }
    
    
    // MARK:- 点击分组按钮
    @objc private func centerBtnClick(sender : WSTitleButton) {
        
        sender.selected = !sender.selected
        
        // 1.创建弹出分组列表
        let popViewController = PopViewController()
        
        //2.设置弹出控制器的相关属性
        popViewController.modalPresentationStyle = .Custom
        popViewController.transitioningDelegate = self
       
        // 3.Modal出分组列表控制器
        presentViewController(popViewController, animated: true, completion: nil)
    }
}


extension HomeViewController : UIViewControllerTransitioningDelegate {
    ///modal出控制器的时候会调用这个方法
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        //传两个参数,init 构造函数
        return WSPresentControler(presentedViewController : presented,presentingViewController : presenting)
        

    }
    
    
    /*这两个函数来源是调用modal  使用必须遵守UIViewControllerAnimatedTransitioning 协议*/
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    
}

extension HomeViewController : UIViewControllerAnimatedTransitioning {
    ///动画完成所需时间
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.1
    }
    // 用来设置modal出现和消失的动画  transitionContext表示这个专场动画
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        // 拿到弹出的view,如果可以拿到就是弹出
        if let presentedView = transitionContext.viewForKey(UITransitionContextToViewKey) {
            //2.将染出的view添加到容器视图中
            transitionContext.containerView()?.addSubview(presentedView)
            //3.给弹出增加动画
            presentedView.transform = CGAffineTransformMakeScale(1.0, 0)
            presentedView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
                presentedView.transform = CGAffineTransformIdentity
                }, completion: { (isFinished) -> Void in
                    //表示完成了专场动画
                    transitionContext.completeTransition(true)
            })
        }
            else {  //presentedView没有拿到值,说明是消失动画
            //1.取出消失的view
            let dismissView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
                //2.给消失view添加动画
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
                dismissView.transform = CGAffineTransformMakeScale(1.0, 0.00001)
                }, completion: { (_) -> Void in
                    //dismiss完成后,需要移除dismissView ,执行方法,告诉动画已完成
                    dismissView.removeFromSuperview()
                    transitionContext.completeTransition(true)
                    self.titleButton.selected = !self.titleButton.selected
            })
            
            }
        }
}
    











