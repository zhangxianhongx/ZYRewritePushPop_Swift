//
//  BaseNavigationController.swift
//  Swift-RewritePushAndPop
//
//  Created by ybon on 2017/3/31.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit
import Foundation
public class BaseNavigationController: UINavigationController ,UINavigationControllerDelegate{

    override public func viewDidLoad() {
        super.viewDidLoad()
        let attrDic = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 17),NSAttributedString.Key.foregroundColor:UIColor.white];
        
        self.navigationBar.titleTextAttributes = attrDic;
//        self.navigationBar.barTintColor = UIColor.white
        //18,150,219
        self.navigationBar.barTintColor = UIColor.init(red: 18/255.0, green: 150/255.0, blue: 219/255.0, alpha: 1.0)
        self.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate;
        self.delegate = self;
    }
    func setStatusColor(){
        
        let statusBarView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 20));
        statusBarView.backgroundColor = UIColor.orange;
        self.view.addSubview(statusBarView);
        
    }
    override public func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        
        super.pushViewController(viewController, animated: animated);
        
        if self.viewControllers.count > 1{
            
            self.createRightBarItemWithViewController(viewController);
            self.createLeftBackBarItemWithViewController(viewController);
        }
        
    }
    override public func popViewController(animated: Bool) -> UIViewController? {
        let vc = super.popViewController(animated: animated);
        
        return vc;
    }
    
    override public func popToRootViewController(animated: Bool) -> [UIViewController]? {
        let vc = super.popToRootViewController(animated: animated);
        
        return vc;
        
    }
    override public func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        let vcs = super.popToViewController(viewController, animated: animated);
        
        return vcs;
    }
    func createRightBarItemWithViewController(_ viewController:UIViewController){
        
    }
    func createLeftBackBarItemWithViewController(_ viewController:UIViewController){
        self.navigationItem.hidesBackButton = true;
        let backItem = UIButton.init(type: UIButton.ButtonType.custom);
        backItem.frame = CGRect.init(x: 0, y: 6, width: 32, height: 32);
        backItem.setImage(UIImage.init(named: "left-arrow.png"), for: UIControl.State.normal);
        backItem.addTarget(self, action: #selector(backToParentView), for: UIControl.Event.touchUpInside);
        let leftBarItem = UIBarButtonItem.init(customView: backItem);
        viewController.navigationItem.leftBarButtonItem = leftBarItem;
    }
    
    @objc func backToParentView(){
        if self.presentationController != nil && self.viewControllers.count == 1 {
            
            self.dismiss(animated: true, completion: nil);
        }else{
            let _ = self.popViewController(animated: true);

        }
    }
//自定义动画
    open func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?{
       
        if operation == UINavigationController.Operation.push{
           
              return getAnimationWithAnimationType(animationTyp: toVC.animationType,operation: operation);
            
        }else{
           
               return getAnimationWithAnimationType(animationTyp: fromVC.animationType,operation: operation);
            
        }
       
    }
    
    
}
