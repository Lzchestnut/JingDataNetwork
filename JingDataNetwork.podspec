#
# Be sure to run `pod lib lint JingDataNetwork.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JingDataNetwork'
  s.version          = '1.0.1'
  s.summary          = 'UU跑腿网络请求公共组件库-Swift'

  s.homepage         = 'http://uugit.uupt.com/zhangwenbin/JingDataNetwork.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tianziyao' => 'tianziyao@jingdata.com' }
  s.source           = { :git => 'http://uugit.uupt.com/zhangwenbin/JingDataNetwork.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.source_files = 'JingDataNetwork/Classes/**/*'
  s.dependency 'Moya'
  s.dependency 'RxSwift', '6.0.0-rc.2'
  s.dependency 'RxCocoa', '6.0.0-rc.2'
  s.dependency 'SwiftyJSON', '5.0.0'

  # s.dependency 'ObjectMapper', '~> 3.3'

  # s.resource_bundles = {
  #   'JingDataNetwork' => ['JingDataNetwork/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
end
