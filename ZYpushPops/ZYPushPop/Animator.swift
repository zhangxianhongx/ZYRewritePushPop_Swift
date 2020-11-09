//
//  Animator.swift
//  Swift-RewritePushAndPop
//
//  Created by 建鑫 on 2017/4/5.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit

class Animator: NSObject,UIViewControllerAnimatedTransitioning {

    var transitionType:UINavigationController.Operation?;
    var animationDuration:TimeInterval = 0.4
    
    fileprivate var animationPushTypeStr:String? = nil
    fileprivate var animationPopTypeStr:String? = nil
    
    init(animationKey: String?) {
        self.animationPushTypeStr = animationKey != nil ? animationKey! : "fade"
        self.animationPopTypeStr = self.animationPushTypeStr == "pageCurl" ? "pageUnCurl" : self.animationPushTypeStr!
    }
    
    
    func push(_ transitionsContext:UIViewControllerContextTransitioning){
        let formVC = transitionsContext.viewController(forKey: UITransitionContextViewControllerKey.from);
        let toVC = transitionsContext.viewController(forKey: UITransitionContextViewControllerKey.to);
        let duration = self.transitionDuration(using: transitionsContext);
        let bounds = UIScreen.main.bounds;
        let containerView = transitionsContext.containerView;
        containerView.addSubview((toVC?.view)!);
        
//        toVC?.navigationController?.view.layer.anchorPoint = CGPoint.init(x: 0.5, y: 2.0);
        toVC?.navigationController?.view.frame = bounds;
        
        let animation = CATransition.init();
        guard self.animationPushTypeStr != nil else {
            print("默认动画")
            return
        }
        animation.type = CATransitionType(rawValue: self.animationPushTypeStr!);
        animation.duration = duration;
        containerView.layer.add(animation, forKey: self.animationPushTypeStr!);
        
        //延迟调用
        let delay = DispatchTime.now() + duration;
        DispatchQueue.main.asyncAfter(deadline: delay) {
//            toVC?.navigationController?.view.layer.anchorPoint = CGPoint.init(x: 0.5, y: 0.5);
            toVC?.view.frame = bounds;
            formVC?.view.isHidden = false;
            transitionsContext.completeTransition(true);
        };
        print("push--\(String(describing: self.animationPushTypeStr))")
    }
    
    func pop(_ transitionsContext:UIViewControllerContextTransitioning){
        let formVC = transitionsContext.viewController(forKey: UITransitionContextViewControllerKey.from);
        let toVC = transitionsContext.viewController(forKey: UITransitionContextViewControllerKey.to);
        let duration = self.transitionDuration(using: transitionsContext);
        let bounds = UIScreen.main.bounds;
        let containerView = transitionsContext.containerView;
        containerView.addSubview((toVC?.view)!);
        
//        formVC?.navigationController?.view.layer.anchorPoint = CGPoint.init(x: 0.5, y: 2.5);
        formVC?.navigationController?.view.frame = bounds;
        
        
        let animation = CATransition.init();
        guard self.animationPushTypeStr != nil else {
            print("默认动画")
            return
        }
        animation.type = CATransitionType(rawValue: self.animationPopTypeStr!);
        animation.duration = duration;
        containerView.layer.add(animation, forKey: self.animationPopTypeStr!);
        //延迟调用
        let delay = DispatchTime.now() + duration;
        DispatchQueue.main.asyncAfter(deadline: delay) {
            
            toVC?.view.isHidden = false;
            transitionsContext.completeTransition(!transitionsContext.transitionWasCancelled);
        };
        print("pop--\(String(describing: self.animationPopTypeStr))")
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.animationDuration;
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if transitionType == UINavigationController.Operation.push{
            push(transitionContext);
        }else{
            pop(transitionContext);
        }
        
        
    }
}
