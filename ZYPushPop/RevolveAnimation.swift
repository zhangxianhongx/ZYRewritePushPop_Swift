//
//  RevolveAnimation.swift
//  Swift-RewritePushAndPop
//
//  Created by ybon on 2017/4/11.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit

class RevolveAnimation: NSObject ,UIViewControllerAnimatedTransitioning{
    
    var transitionType:UINavigationController.Operation?;
    
    
    func push(_ transitionsContext:UIViewControllerContextTransitioning){
        let formVC = transitionsContext.viewController(forKey: UITransitionContextViewControllerKey.from);
        let toVC = transitionsContext.viewController(forKey: UITransitionContextViewControllerKey.to);
        let duration = self.transitionDuration(using: transitionsContext);
        let bounds = UIScreen.main.bounds;
        let containerView = transitionsContext.containerView;
        
        
        containerView.addSubview((toVC?.view)!);
        toVC?.view.layer.anchorPoint = CGPoint.init(x: 0.5, y: 2.0);
        toVC?.view.frame = bounds;
        let rotation = 0.5 * M_PI;
        toVC?.view.transform = CGAffineTransform.init(rotationAngle: CGFloat(rotation));
        UIView.animate(withDuration: duration, animations: { 
            toVC?.view.transform = CGAffineTransform.identity;
            }) { (isStope) in
                toVC?.view.layer.anchorPoint = CGPoint.init(x: 0.5, y: 0.5);
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
        
        containerView.insertSubview((toVC?.view)!, belowSubview: (formVC?.view)!);
      formVC?.view.layer.anchorPoint = CGPoint.init(x: 0.5, y: 2.5);
        formVC?.view.frame = bounds;
        UIView.animate(withDuration: duration, animations: {
            
//            formVC?.view.transform = CGAffineTransform.init(translationX: 300, y: 0);
            let rotation = 0.122 * M_PI;
            formVC?.view.transform = CGAffineTransform.init(rotationAngle: CGFloat(rotation));
        }) { (isStope) in
            formVC?.view.transform = CGAffineTransform.identity;
             formVC?.view.layer.anchorPoint = CGPoint.init(x: 0.5, y: 0.5);
    
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
