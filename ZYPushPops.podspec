

Pod::Spec.new do |s|


  s.name         = "ZYPushPops"
  s.version      = "0.0.9"
  s.license      = "MIT"
  s.summary      = "Swift custom push and pop animation, developer zhang xianhong"
  s.homepage     = "https://github.com/zhangxianhongx/ZYRewritePushPop_Swift"

  s.author             = { "贝尔特伦" => "384323457@qq.com" }
  s.source       = { :git => "https://github.com/zhangxianhongx/ZYRewritePushPop_Swift.git", :tag => s.version }

  s.ios.deployment_target = "8.0"

  s.source_files  = "ZYPushPop/*"

end
