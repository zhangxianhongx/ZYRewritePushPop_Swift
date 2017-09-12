# 效果图 <br>
![image](https://github.com/zhangxianhongx/ZYRewritePushPop_Swift/blob/master/01.gif) <br>

# ZYRewritePushPop_Swift <br>
1，自定义push和pop功能，多种动画，随意配置 <br>
2，可为任何Controller单独配置相应的动画 <br>
3，耦合性低，框架中个动画模块相互独立，可随意修改替换 <br>
4，扩展性强，开发者可以选择更改，替换，增加源码中的动画，这些在你简单的了解框架的架构之后即可完成 <br>

## 简书教程
http://www.jianshu.com/p/966aaba5e044

# 使用介绍：

1，将源码中的BaseConfiger文件夹下文件全部拖入项目 <br>
2，BaseNavigationController的作用大家都知道，如果你是用的xib那么请将xib继承它 
在BaseNavigationController中，开发者可更改导航栏的属性，如导航栏颜色，标题颜色等等 <br>
3，ZYViewControllerExtension的作用 
ZYViewControllerExtension是一个中转处理类，用来处理各种动画以及给push和pop配置动画 <br>

## 2017-05-27 <br>
增加左右扫描和上下扫描动画
## 2017-09-10 本库已经支持pod安装，库名为ZYPushPop <br>
推荐手动导入 <br>
pod 'ZYPushPops' <br>

### 本框架为两人功能开发，各位有什么问题可直接通过邮箱384323457@qq.com联系我，也可在简书中给我留言。


