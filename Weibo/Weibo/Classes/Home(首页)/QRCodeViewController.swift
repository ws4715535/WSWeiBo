//
//  QRCodeViewController.swift
//  Weibo
//
//  Created by Ws on 16/1/11.
//  Copyright © 2016年 Ws. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeViewController: UIViewController {
    ///Tabbar
    @IBOutlet weak var qrTabbar: UITabBar!
    ///内容视图高度
    @IBOutlet weak var containViewHeight: NSLayoutConstraint!
    ///扫描图案到父控件的Top约束
    @IBOutlet weak var scanVIewTop: NSLayoutConstraint!
    ///扫描图案
    @IBOutlet weak var scanImageView: UIImageView!
    ///结果Label
    @IBOutlet weak var resultLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // 1.设置默认选择
        qrTabbar.selectedItem = qrTabbar.items![0]
        
        // 2.添加扫描动画
        startScanAnimation()
        
        // 3.开始扫描二维码
        startScanQRCode()
    }
    
    // MARK:- 开始扫描二维码操作
    private func startScanQRCode() {
        //1.创建捕捉会话
        let session = AVCaptureSession()
        
        //2.添加输入设备
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        guard let input = try? AVCaptureDeviceInput(device: device) else {
            print("无法检测到输入设备")
            return
        }
        
        session.addInput(input)
        
        
        //3.添加输出(metadata方式输出)
        let output = AVCaptureMetadataOutput()
        output.setMetadataObjectsDelegate(self, queue:dispatch_get_main_queue())
        session.addOutput(output)
        output.metadataObjectTypes = output.availableMetadataObjectTypes //?
        
        
        //4.添加预览图层 也就是打开摄像头后的展示的图层
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = view.bounds
        print(view.bounds)
            //添加到最底下
        view.layer.insertSublayer(previewLayer, atIndex: 0)
        
        //5.开始扫描 开始执行捕捉会话
        session.startRunning()
    }
    
    
    
    
    // MARK:- 扫描的动画
    private func startScanAnimation() {
        //让View在最上面,开始动画
        scanVIewTop.constant = -containViewHeight.constant
        view.layoutIfNeeded()
        //增加动画
        UIView.animateWithDuration(2) { () -> Void in
            UIView.setAnimationRepeatCount(MAXFLOAT)
            self.scanVIewTop.constant = self.containViewHeight.constant
            self.view.layoutIfNeeded()
        }
 
        
    }
    
    
    
    // MARK:- 监听顶部按钮点击
    @IBAction func closeBtnClick(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    @IBAction func albumsBtnClick(sender: AnyObject) {
        //1.判断照片源是否可用
        if !UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            print("照片库不可用")
            return
        }
        
        //2.创建照片选择器控制器
        let ipc = UIImagePickerController()
        
        //3.设置照片源
        ipc.sourceType = .PhotoLibrary
        
        //4.设置代理
        ipc.delegate = self
        
        //5.弹出照片选择控制器
        presentViewController(ipc, animated: true, completion: nil)
        
    }
 
}



// MARK:- 照片选择器代理方法
extension QRCodeViewController : UIImagePickerControllerDelegate ,UINavigationControllerDelegate {
    
}


// MARK:- 输出设备代理方法  这里可以拿到扫描结果
extension QRCodeViewController : AVCaptureMetadataOutputObjectsDelegate {
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        // 1.没有结果
        guard let outputObject = metadataObjects.last as? AVMetadataMachineReadableCodeObject else {
            print("没有获得扫描结果")
            return
        }
        // 2.拿到结果并显示
        self.resultLabel.text = outputObject.stringValue
    }
    
    
}


// MARK:- Tabbar的代理方法
extension QRCodeViewController : UITabBarDelegate {

    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        //根据tag值判断是扫描二维码还是条形码
        self.containViewHeight.constant = item.tag == 0 ? 250 : 150
        
        //先移除当前动画
        view.layer.removeAllAnimations()
        
        //再开始新动画
        startScanAnimation()
    }
    
    
}


