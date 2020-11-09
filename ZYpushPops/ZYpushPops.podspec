#
# Be sure to run `pod lib lint ZYpushPops.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name         = "ZYPushPops"
  s.version      = "0.1.0"
  s.license      = "MIT"
  s.summary      = "Swift custom push and pop animation, developer zhang xianhong"
  s.homepage     = "https://github.com/zhangxianhongx/ZYRewritePushPop_Swift"

  s.author             = { "贝尔特伦" => "384323457@qq.com" }
  s.source       = { :git => "https://github.com/zhangxianhongx/ZYRewritePushPop_Swift.git", :tag => s.version }

  s.ios.deployment_target = "8.0"

  s.source_files  = "ZYPushPop/*"
end
