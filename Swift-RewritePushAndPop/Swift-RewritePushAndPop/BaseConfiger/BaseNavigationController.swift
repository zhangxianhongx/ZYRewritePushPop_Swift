//
//  BaseNavigationController.swift
//  Swift-RewritePushAndPop
//
//  Created by ybon on 2017/3/31.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit
import Foundation
class BaseNavigationController: UINavigationController ,UINavigationControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        let attrDic = [NSFontAttributeName:UIFont.systemFont(ofSize: 17),NSForegroundColorAttributeName:UIColor.white];
        
        self.navigationBar.titleTextAttributes = attrDic;
        self.navigationBar.barTintColor = UIColor.init(colorLiteralRed: 176/255.0, green: 11/255.0, blue: 19/255.0, alpha: 1.0);
        self.delegate = self;
    }
    func setStatusColor(){
        
        let statusBarView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 20));
        statusBarView.backgroundColor = UIColor.orange;
        self.view.addSubview(statusBarView);
        
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated);
        
        if self.viewControllers.count > 1{
            
            self.createRightBarItemWithViewController(viewController: viewController);
            self.createLeftBackBarItemWithViewController(viewController: viewController);
        }
        
    }
    override func popViewController(animated: Bool) -> UIViewController? {
        let vc = super.popViewController(animated: animated);
        
        return vc;
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        let vc = super.popToRootViewController(animated: animated);
        
        return vc;
        
    }
    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        let vcs = super.popToViewController(viewController, animated: animated);
        
        return vcs;
    }
    func createRightBarItemWithViewController(viewController:UIViewController){
        
    }
    func createLeftBackBarItemWithViewController(viewController:UIViewController){
        self.navigationItem.hidesBackButton = true;
        let backItem = UIButton.init(type: UIButtonType.custom);
        backItem.frame = CGRect.init(x: 0, y: 6, width: 32, height: 32);
        backItem.setImage(UIImage.init(named: "left-arrow.png"), for: UIControlState.normal);
        backItem.addTarget(self, action: #selector(backToParentView), for: UIControlEvents.touchUpInside);
        let leftBarItem = UIBarButtonItem.init(customView: backItem);
        viewController.navigationItem.leftBarButtonItem = leftBarItem;
    }
    
    func backToParentView(){
        if self.presentationController != nil && self.viewControllers.count == 1 {
            
            self.dismiss(animated: true, completion: nil);
        }else{
            let vc = self.popViewController(animated: true);
            print(vc?.classForCoder);
        }
    }
//自定义动画
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        
        if operation == UINavigationControllerOperation.push{
            if toVC.animationType == nil{
                
                return nil;
            }else{
              return getAnimationWithAnimationType(animationTyp: toVC.animationType!,operation: operation);
            }
        }else{
            if fromVC.animationType == nil{
                
                return nil;
            }else{
               return getAnimationWithAnimationType(animationTyp: fromVC.animationType!,operation: operation);
            }
        }
       
    }
    
    
}
