//
//  PiecesAnimation.swift
//  Swift-RewritePushAndPop
//
//  Created by ybon on 2017/5/31.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit

class PiecesAnimation: NSObject {

    var transitionType:UINavigationController.Operation?;
    
    
    
    func push(_ transitionsContext:UIViewControllerContextTransitioning){
        let formVC = transitionsContext.viewController(forKey: UITransitionContextViewControllerKey.from);
        let toVC = transitionsContext.viewController(forKey: UITransitionContextViewControllerKey.to);
        let duration = self.transitionDuration(using: transitionsContext);
        let bounds = UIScreen.main.bounds;
        let containerView = transitionsContext.containerView;
        
        toVC?.view.frame = bounds;
        toVC?.navigationController?.view.frame = bounds;
        
        let count = 6;
        for i in 0..<count {
            let rect = CGRect.init(x: 0, y: bounds.size.height/CGFloat(count) * CGFloat(i), width: bounds.width, height: bounds.height/CGFloat(count));
            let coverV = CoverView.init(frame: CGRect.init(x: 0, y: -500, width: bounds.width, height: bounds.height/CGFloat(count)));
            coverV.getRectView(toVC!, rect: rect);
            coverV.tag = 2017 + i;
            formVC?.view.addSubview(coverV);
        }
        UserDefaults.standard.set((count), forKey: "count");
        pushAnimation(duration, ViewC: formVC!);
        //延迟调用
        let delay = DispatchTime.now() + duration;
        DispatchQueue.main.asyncAfter(deadline: delay) {
            containerView.addSubview((toVC?.view)!);
            toVC?.view.center = containerView.center;
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
        containerView.addSubview((toVC?.view)!);
        
        formVC?.navigationController?.view.frame = bounds;
        let count = 6;
        for i in 0..<count {
            let rect = CGRect.init(x: 0, y: bounds.size.height/CGFloat(count) * CGFloat(i), width: bounds.width, height: bounds.height/CGFloat(count));
            let coverV = CoverView.init(frame: CGRect.init(x: 0, y: CGFloat(i) * bounds.height/CGFloat(count), width: bounds.width, height: bounds.height/CGFloat(count)));
            coverV.getRectView(formVC!, rect: rect);
            coverV.tag = 2016 + i;
            toVC?.view.addSubview(coverV);
        }
        UserDefaults.standard.set((count), forKey: "count");
        popAnimation(duration, ViewC: toVC!);
        //延迟调用
        let delay = DispatchTime.now() + duration;
        DispatchQueue.main.asyncAfter(deadline: delay) {
            
            formVC?.view.center = containerView.center;
            toVC?.view.isHidden = false;
            transitionsContext.completeTransition(!transitionsContext.transitionWasCancelled);
        };
        
        
        
        
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.8;
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if transitionType == UINavigationController.Operation.push{
            push(transitionContext);
        }else{
            pop(transitionContext);
        }
        
        
    }
    
    func pushAnimation(_ duration:TimeInterval,ViewC:UIViewController) {
        
   
    }
    func popAnimation(_ duration:TimeInterval,ViewC:UIViewController){
       
    }

    
    
    
}
/**
 * 遮盖视图
 */
class PCoverView: UIView {
    
    func getRectView(_ viewC:UIViewController,rect:CGRect){
        
        UIGraphicsBeginImageContextWithOptions(UIScreen.main.bounds.size, false, UIScreen.main.scale)
        let ref = UIGraphicsGetCurrentContext();
        
        ref?.clip(to: viewC.view.frame);
        viewC.view.layer.render(in: ref!);
        let img1 = UIGraphicsGetImageFromCurrentImageContext();
        /***************************/
        let cgimage = img1?.cgImage;
        let cgwidth = cgimage!.width;
        
        let bili = CGFloat(cgwidth)/UIScreen.main.bounds.size.width;
        
        let y = rect.origin.y/UIScreen.main.bounds.size.height * (img1?.size.height)! * CGFloat(bili);
        
        let width = (img1?.size.width)! * CGFloat(bili);
        let height = rect.size.height / UIScreen.main.bounds.size.height * (img1?.size.height)! * CGFloat(bili);
        
        let img2 = UIImage.init(cgImage: (img1?.cgImage)!.cropping(to: CGRect.init(x: 0, y: y, width: width, height: height))!);
        UIGraphicsEndImageContext();
        
        let imageV = UIImageView.init(frame: self.bounds);
        imageV.contentMode = UIView.ContentMode.scaleAspectFit;
        imageV.image = img2;
        self.addSubview(imageV);
    }
    
}
