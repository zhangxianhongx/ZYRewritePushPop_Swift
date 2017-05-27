//
//  ZYViewControllerExtension.swift
//  Swift-RewritePushAndPop
//
//  Created by ybon on 2017/3/31.
//  Copyright © 2017年 ybon. All rights reserved.
//

import Foundation
import UIKit
/**
 *   动画类型枚举
 *   后期开发若要添加新的动画，只需把动画类型加入枚举即可
 */
enum UIViewControllerAnimationTypeName {
    /**
     * 翻页效果
     */
    case pageCurlAnimation
    /**
     * 淡入淡出效果
     */
    case fadeAnimation
    /**
     * 立方体翻转效果
     */
    case cubeAnimation
    /**
     * 吸纸效果
     */
    case suckEffectAnimation
    /**
     * 水波效果
     */
    case rippleEffectAnimation
    /**
     * 缩放效果
     */
    case scaleAnimation
    /**
     * 切圆效果
     */
    case roundAnimation
    /**
     * 翻转效果
     */
    case flipOverAnimation
    /**
     * 单一填充动画
     */
    case accumulateAnimation
    /**
     * 旋转动画
     */
    case revolveAnimation
    /**
     左右扫描
     */
    case rlScanAnimation
    /**
     上下扫描
     */
    case tbScanAnimation
}
/**
 * 确定对象使用的哪一种动画
 * 新添加的动画需要在这里写出
 */
func getAnimationWithAnimationType(animationTyp:UIViewControllerAnimationTypeName,operation:UINavigationControllerOperation)-> UIViewControllerAnimatedTransitioning?{
    
    switch animationTyp {
    
    case .pageCurlAnimation:
        let animation = Animator.init(animationKey: "pageCurl");
        animation.transitionType = operation;
        return animation;
    case .fadeAnimation:
        let animation = Animator.init(animationKey: "fade");
        animation.transitionType = operation;
        return animation;
    case .cubeAnimation:
        let animation = Animator.init(animationKey: "cube");
        animation.transitionType = operation;
        return animation;
    case .suckEffectAnimation:
        let animation = Animator.init(animationKey: "suckEffect");
        animation.transitionType = operation;
        return animation;
    case .rippleEffectAnimation:
        let animation = Animator.init(animationKey: "rippleEffect");
        animation.transitionType = operation;
        return animation;

    case .scaleAnimation:
        let animation = ScaleAnimation.init();
        animation.transitionType = operation;
        return animation;
    case .roundAnimation:
        let animation = RoundAnimation.init();
        animation.transitionType = operation;
        return animation;
    case .flipOverAnimation:
        let animation = FlipOverAnimation.init();
        animation.transitionType = operation;
        return animation;
    case .accumulateAnimation:
        let animation = AccumulateAnimation.init();
        animation.transitionType = operation;
        return animation;
    case .revolveAnimation:
        let animation = RevolveAnimation.init();
        animation.transitionType = operation;
        return animation;
    case .rlScanAnimation:
        let animation = RLScanAnimation.init();
        animation.transitionType = operation;
        return animation;
    case .tbScanAnimation:
        let animation = TBScanAnimation.init();
        animation.transitionType = operation;
        return animation;
        
    }
    
}



/**
 *  extension
 *  为所有UIViewController及其子类添加上述枚举类型属性
 *  给某个Controller定义动画时，只需给属性赋上相应动画类型
 */
extension UIViewController{
    
    private static var animationTypeKey = "animationTypeKey";
    var animationType:UIViewControllerAnimationTypeName?{
        set {
            objc_setAssociatedObject(self,  &UIViewController.animationTypeKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        get {
            return objc_getAssociatedObject(self, &UIViewController.animationTypeKey) as! UIViewControllerAnimationTypeName?;
        }
    }
    /* 待确定功能
    private static var animationNameKey = "animationNameKey";
    var animationName : String?{
        set {
            objc_setAssociatedObject(self,  &UIViewController.animationNameKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        get {
            return objc_getAssociatedObject(self, &UIViewController.animationNameKey) as? String;
        }
    }
    */
}
