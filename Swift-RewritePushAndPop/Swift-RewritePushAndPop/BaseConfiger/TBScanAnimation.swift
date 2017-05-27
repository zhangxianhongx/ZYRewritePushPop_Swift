//
//  TBScanAnimation.swift
//  Swift-RewritePushAndPop
//
//  Created by ybon on 2017/5/27.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit

class TBScanAnimation: NSObject ,UIViewControllerAnimatedTransitioning{
    
    var transitionType:UINavigationControllerOperation?;
    
    func push(transitionsContext:UIViewControllerContextTransitioning){
        let formVC = transitionsContext.viewController(forKey: UITransitionContextViewControllerKey.from);
        let toVC = transitionsContext.viewController(forKey: UITransitionContextViewControllerKey.to);
        let duration = self.transitionDuration(using: transitionsContext);
        let bounds = UIScreen.main.bounds;
        let containerView = transitionsContext.containerView;
        containerView.addSubview((toVC?.view)!);
        toVC?.view.frame = bounds;
        
        let startPath = UIBezierPath.init(rect: CGRect.init(x:0, y: bounds.size.height, width: bounds.size.width, height:0));
        let endPath = UIBezierPath.init(rect: CGRect.init(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height));
        let maskLayer = CAShapeLayer.init();
        maskLayer.path = endPath.cgPath;
        toVC?.view.layer.mask = maskLayer;
        let animation = CABasicAnimation.init(keyPath: "path");
        animation.fromValue = startPath.cgPath;
        animation.toValue = endPath.cgPath;
        animation.duration = duration;
        animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut);
        maskLayer.add(animation, forKey: "startAnimation");
        
        
        //延迟调用
        let delay = DispatchTime.now() + duration;
        DispatchQueue.main.asyncAfter(deadline: delay) {
            toVC?.view.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
            
            toVC?.view.center = containerView.center;
            toVC?.navigationController?.view.frame = bounds;
            formVC?.view.isHidden = false;
            transitionsContext.completeTransition(true);
        };
    }
    func pop(transitionsContext:UIViewControllerContextTransitioning){
        let formVC = transitionsContext.viewController(forKey: UITransitionContextViewControllerKey.from);
        let toVC = transitionsContext.viewController(forKey: UITransitionContextViewControllerKey.to);
        let duration = self.transitionDuration(using: transitionsContext);
        let bounds = UIScreen.main.bounds;
        let containerView = transitionsContext.containerView;
        //        containerView.addSubview((toVC?.view)!);
        
        containerView.insertSubview((toVC?.view)!, belowSubview: (formVC?.view)!);
        formVC?.navigationController?.view.frame = bounds;
        
        let endPath = UIBezierPath.init(rect: CGRect.init(x:0, y: bounds.size.height, width: bounds.size.width, height:0));
        let startPath = UIBezierPath.init(rect: CGRect.init(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height));      let maskLayer = CAShapeLayer.init();
        maskLayer.path = endPath.cgPath;
        formVC?.view.layer.mask = maskLayer;
        let animation = CABasicAnimation.init(keyPath: "path");
        animation.fromValue = startPath.cgPath;
        animation.toValue = endPath.cgPath;
        animation.duration = duration;
        animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut);
        maskLayer.add(animation, forKey: "endAnimation");
        
        
        //延迟调用
        let delay = DispatchTime.now() + duration;
        DispatchQueue.main.asyncAfter(deadline: delay) {
            formVC?.view.frame = CGRect.zero;
            formVC?.view.center = containerView.center;
            toVC?.view.isHidden = false;
            transitionsContext.completeTransition(!transitionsContext.transitionWasCancelled);
        };
        
        
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4;
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if transitionType == UINavigationControllerOperation.push{
            push(transitionsContext: transitionContext);
        }else{
            pop(transitionsContext: transitionContext);
        }
        
        
    }
}
