//
//  AccumulateAnimation.swift
//  Swift-RewritePushAndPop
//
//  Created by ybon on 2017/4/6.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit

class AccumulateAnimation: NSObject ,UIViewControllerAnimatedTransitioning{
    
    var transitionType:UINavigationControllerOperation?;
    
    
    
    func push(transitionsContext:UIViewControllerContextTransitioning){
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
            coverV.getRectView(viewC: toVC!, rect: rect);
            coverV.tag = 2017 + i;
            formVC?.view.addSubview(coverV);
        }
        UserDefaults.standard.set((count), forKey: "count");
        pushAnimation(duration: duration, ViewC: formVC!);
        //延迟调用
        let delay = DispatchTime.now() + duration;
        DispatchQueue.main.asyncAfter(deadline: delay) {
            containerView.addSubview((toVC?.view)!);
            toVC?.view.center = containerView.center;
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
        containerView.addSubview((toVC?.view)!);

        formVC?.navigationController?.view.frame = bounds;
        let count = 6;
        for i in 0..<count {
            let rect = CGRect.init(x: 0, y: bounds.size.height/CGFloat(count) * CGFloat(i), width: bounds.width, height: bounds.height/CGFloat(count));
            let coverV = CoverView.init(frame: CGRect.init(x: 0, y: CGFloat(i) * bounds.height/CGFloat(count), width: bounds.width, height: bounds.height/CGFloat(count)));
            coverV.getRectView(viewC: formVC!, rect: rect);
            coverV.tag = 2016 + i;
            toVC?.view.addSubview(coverV);
        }
        UserDefaults.standard.set((count), forKey: "count");
        popAnimation(duration: duration, ViewC: toVC!);
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
        
        if transitionType == UINavigationControllerOperation.push{
            push(transitionsContext: transitionContext);
        }else{
            pop(transitionsContext: transitionContext);
        }
        
        
    }
    
    func pushAnimation(duration:TimeInterval,ViewC:UIViewController) {
        
        UIView.animate(withDuration: duration/TimeInterval(6), animations: {
            let count:NSNumber = UserDefaults.standard.object(forKey: "count") as! NSNumber;
            let resultCount = count.intValue-1;
            let cView = ViewC.view.viewWithTag(2017 + resultCount);
            cView?.frame = CGRect.init(x: 0, y: CGFloat(resultCount) * (cView?.bounds.size.height)!, width: (cView?.bounds.width)!, height: (cView?.bounds.height)!);
            
            
            }) { (isStop) in
                let count:NSNumber = UserDefaults.standard.object(forKey: "count") as! NSNumber;
                let resultCount = count.intValue - 1;
                if resultCount >= 0{
                    UserDefaults.standard.set((resultCount), forKey: "count");
                    self.pushAnimation(duration: duration, ViewC: ViewC);
                }else{
                    UserDefaults.standard.set((resultCount), forKey: "count");
                    for i in 0...5{
                        let vc = ViewC.view.viewWithTag(i + 2017);
                        vc?.removeFromSuperview();
                    }
                }
        }
        
    }
    func popAnimation(duration:TimeInterval,ViewC:UIViewController){
        UIView.animate(withDuration: duration/TimeInterval(6), animations: {
            let count:NSNumber = UserDefaults.standard.object(forKey: "count") as! NSNumber;
            let resultCount = count.intValue-1;
            let cView = ViewC.view.viewWithTag(2016 + resultCount);
            cView?.frame = CGRect.init(x: 0, y: ViewC.view.bounds.size.height, width: (cView?.bounds.width)!, height: (cView?.bounds.height)!);
            
            
        }) { (isStop) in
            let count:NSNumber = UserDefaults.standard.object(forKey: "count") as! NSNumber;
            let resultCount = count.intValue - 1;
            if resultCount >= 0{
                UserDefaults.standard.set((resultCount), forKey: "count");
                self.popAnimation(duration: duration, ViewC: ViewC);
            }else{
                UserDefaults.standard.set((resultCount), forKey: "count");
                for i in 0...5{
                    let vc = ViewC.view.viewWithTag(i + 2016);
                    vc?.removeFromSuperview();
                }
            }
        }

    }
}
/**
 * 遮盖视图
 */
class CoverView: UIView {

    func getRectView(viewC:UIViewController,rect:CGRect){
        
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
        imageV.contentMode = UIViewContentMode.scaleAspectFit;
        imageV.image = img2;
        self.addSubview(imageV);
    }
  
}
