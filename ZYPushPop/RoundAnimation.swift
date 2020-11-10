//
//  RoundAnimation.swift
//  Swift-RewritePushAndPop
//
//  Created by ybon on 2017/4/5.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit
enum AnimationDirection {
    /**圆形*/
    case round
    /**左右*/
    case rightLeft
    /**上下*/
    case topButtom
}
class RoundAnimation: NSObject ,UIViewControllerAnimatedTransitioning{
    
    var transitionType:UINavigationController.Operation?;
    var animationDirection:AnimationDirection?;
    
    func push(_ transitionsContext:UIViewControllerContextTransitioning){
        let formVC = transitionsContext.viewController(forKey: UITransitionContextViewControllerKey.from);
        let toVC = transitionsContext.viewController(forKey: UITransitionContextViewControllerKey.to);
        let duration = self.transitionDuration(using: transitionsContext);
        let bounds = UIScreen.main.bounds;
        let containerView = transitionsContext.containerView;
        containerView.addSubview((toVC?.view)!);
        toVC?.view.frame = bounds;
        let frame = CGRect.init(x: UIScreen.main.bounds.size.width/2.0, y: UIScreen.main.bounds.size.height/2.0, width: 1, height: 1);
        
        var maxRadiu:Float = 0;
        let p1 = CGPoint.init(x: 0, y: 0);
        let p2 = CGPoint.init(x: UIScreen.main.bounds.size.width, y: 0);
        let p3 = CGPoint.init(x: 0, y: UIScreen.main.bounds.size.height);
        let p4 = CGPoint.init(x: UIScreen.main.bounds.size.width, y: UIScreen.main.bounds.size.height);
        let arr = [NSValue.init(cgPoint: p1),NSValue.init(cgPoint: p2),NSValue.init(cgPoint: p3),NSValue.init(cgPoint: p4)];
        for value in arr {
            let p = value.cgPointValue;
            let x = p.x;
            let y = p.y;
            maxRadiu = maxRadiu > sqrtf(Float(x * x) + Float(y * y)) ? maxRadiu:sqrtf(Float(x * x) + Float(y * y));
        }
        var startPath = UIBezierPath.init(ovalIn: frame);
        var endPath = UIBezierPath.init(ovalIn: CGRect.init(x: p4.x*1.5, y: -50, width: CGFloat(-maxRadiu), height: CGFloat(maxRadiu)));
        
        if animationDirection == .rightLeft {
            startPath = UIBezierPath.init(rect: CGRect.init(x:bounds.size.width, y: 0, width: 0, height: bounds.size.height));
            endPath = UIBezierPath.init(rect: CGRect.init(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height));
            
        }else if animationDirection == .topButtom{
            
            startPath = UIBezierPath.init(rect: CGRect.init(x:0, y: bounds.size.height, width: bounds.size.width, height:0));
            endPath = UIBezierPath.init(rect: CGRect.init(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height));
        }
        
        let maskLayer = CAShapeLayer.init();
        maskLayer.path = endPath.cgPath;
        toVC?.view.layer.mask = maskLayer;
        let animation = CABasicAnimation.init(keyPath: "path");
        animation.fromValue = startPath.cgPath;
        animation.toValue = endPath.cgPath;
        animation.duration = duration;
        animation.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeOut);
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
    func pop(_ transitionsContext:UIViewControllerContextTransitioning){
        let formVC = transitionsContext.viewController(forKey: UITransitionContextViewControllerKey.from);
        let toVC = transitionsContext.viewController(forKey: UITransitionContextViewControllerKey.to);
        let duration = self.transitionDuration(using: transitionsContext);
        let bounds = UIScreen.main.bounds;
        let containerView = transitionsContext.containerView;
        //        containerView.addSubview((toVC?.view)!);
        
        containerView.insertSubview((toVC?.view)!, belowSubview: (formVC?.view)!);
        formVC?.navigationController?.view.frame = bounds;
        
        let frame = CGRect.init(x: UIScreen.main.bounds.size.width/2.0, y: UIScreen.main.bounds.size.height/2.0, width: 1, height: 1);

        
        var maxRadiu:Float = 0;
        let p1 = CGPoint.init(x: 0, y: 0);
        let p2 = CGPoint.init(x: UIScreen.main.bounds.size.width, y: 0);
        let p3 = CGPoint.init(x: 0, y: UIScreen.main.bounds.size.height);
        let p4 = CGPoint.init(x: UIScreen.main.bounds.size.width, y: UIScreen.main.bounds.size.height);
        let arr = [NSValue.init(cgPoint: p1),NSValue.init(cgPoint: p2),NSValue.init(cgPoint: p3),NSValue.init(cgPoint: p4)];
        for value in arr {
            let p = value.cgPointValue;
            let x = p.x;
            let y = p.y;
            maxRadiu = maxRadiu > sqrtf(Float(x * x) + Float(y * y)) ? maxRadiu:sqrtf(Float(x * x) + Float(y * y));
        }
        var endPath = UIBezierPath.init(ovalIn: frame);
        
        var startPath = UIBezierPath.init(ovalIn: CGRect.init(x: p4.x*1.5, y:0, width: CGFloat(-maxRadiu), height: CGFloat(maxRadiu)));
        if animationDirection == .rightLeft {
            endPath = UIBezierPath.init(rect: CGRect.init(x:bounds.size.width, y: 0, width: 0, height: bounds.size.height));
            startPath = UIBezierPath.init(rect: CGRect.init(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height));
            
        }else if animationDirection == .topButtom{
            endPath = UIBezierPath.init(rect: CGRect.init(x:0, y: bounds.size.height, width: bounds.size.width, height:0));
            startPath = UIBezierPath.init(rect: CGRect.init(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height));
            
        }
        
        let maskLayer = CAShapeLayer.init();
        maskLayer.path = endPath.cgPath;
        formVC?.view.layer.mask = maskLayer;
        let animation = CABasicAnimation.init(keyPath: "path");
        animation.fromValue = startPath.cgPath;
        animation.toValue = endPath.cgPath;
        animation.duration = duration;
        animation.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeOut);
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
        
        if transitionType == UINavigationController.Operation.push{
            push(transitionContext);
        }else{
            pop(transitionContext);
        }
        
        
    }
}
