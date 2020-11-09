//
//  ScaleAnimation.swift
//  Swift-RewritePushAndPop
//
//  Created by zhangxianhonog on 17/4/4.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit

class ScaleAnimation: NSObject,UIViewControllerAnimatedTransitioning{
    
    var transitionType:UINavigationController.Operation?;
    
    
    func push(_ transitionsContext:UIViewControllerContextTransitioning){
        let formVC = transitionsContext.viewController(forKey: UITransitionContextViewControllerKey.from);
        let toVC = transitionsContext.viewController(forKey: UITransitionContextViewControllerKey.to);
        let duration = self.transitionDuration(using: transitionsContext);
        let bounds = UIScreen.main.bounds;
        let containerView = transitionsContext.containerView;
        containerView.addSubview((toVC?.view)!);
        
        toVC?.navigationController?.view.frame = bounds;
        
        let transStart = CGAffineTransform.init(scaleX: 0.1, y: 0.1);
        toVC?.view.transform = transStart;
        toVC?.view.center = containerView.center;
        UIView.animate(withDuration: duration, animations: { 
            
            let transEnd = CGAffineTransform.init(scaleX: 0.9, y: 0.9);
            toVC?.view.transform = transEnd;
            toVC?.view.center = containerView.center;
            
            }) { (isSure) in
                toVC?.view.frame = bounds;
                formVC?.view.isHidden = false;
                transitionsContext.completeTransition(true);
        }
       
        
    }
    func pop(_ transitionsContext:UIViewControllerContextTransitioning){
        let formVC = transitionsContext.viewController(forKey: UITransitionContextViewControllerKey.from);
        let toVC = transitionsContext.viewController(forKey: UITransitionContextViewControllerKey.to);
        let duration = self.transitionDuration(using: transitionsContext);
        let bounds = UIScreen.main.bounds;
        let containerView = transitionsContext.containerView;
//        containerView.addSubview((toVC?.view)!);

        containerView.insertSubview((toVC?.view)!, belowSubview: (formVC?.view)!);
        formVC?.navigationController?.view.frame = bounds;
      
        UIView.animate(withDuration: duration, animations: {
            
            let transStart = CGAffineTransform.init(scaleX: 0.01, y: 0.01);
            formVC?.view.transform = transStart;
            formVC?.view.center = containerView.center;
            
        }) { (isSure) in
            
            toVC?.view.isHidden = false;
            transitionsContext.completeTransition(!transitionsContext.transitionWasCancelled);
        }

        
        
        
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4;
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if transitionType == UINavigationController.Operation.push{
            push(transitionContext);
        }else{
            pop(transitionContext);
        }
        
        
    }
}
