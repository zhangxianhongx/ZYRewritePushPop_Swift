//
//  FlipOverAnimation.swift
//  Swift-RewritePushAndPop
//
//  Created by ybon on 2017/4/6.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit

class FlipOverAnimation: NSObject ,UIViewControllerAnimatedTransitioning{
    
    var transitionType:UINavigationController.Operation?;
    
    
    func push(_ transitionsContext:UIViewControllerContextTransitioning){
        let formVC = transitionsContext.viewController(forKey: UITransitionContextViewControllerKey.from);
        let toVC = transitionsContext.viewController(forKey: UITransitionContextViewControllerKey.to);
        let duration = self.transitionDuration(using: transitionsContext);
        let bounds = UIScreen.main.bounds;
        let containerView = transitionsContext.containerView;
        containerView.addSubview((toVC?.view)!);
        toVC?.view.frame = bounds;
        toVC?.navigationController?.view.frame = bounds;

        //设置动画的过度形式
        
        let transR = UIView.AnimationTransition.flipFromRight;
 
        UIView.animate(withDuration: duration, animations: { 
            
            UIView.setAnimationTransition(transR, for: (toVC?.navigationController?.view)!, cache: false);
            
            }) { (isStop) in
                 toVC?.view.center = containerView.center;
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
        containerView.addSubview((toVC?.view)!);
        

        formVC?.navigationController?.view.frame = bounds;
        
        let transL = UIView.AnimationTransition.flipFromLeft;
        
        UIView.animate(withDuration: duration, animations: {
            
            UIView.setAnimationTransition(transL, for: (toVC?.navigationController?.view)!, cache: false);
            
        }) { (isStop) in
            formVC?.view.center = containerView.center;
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
