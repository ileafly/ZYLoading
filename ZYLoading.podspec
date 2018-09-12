#
# Be sure to run `pod lib lint ZYLoading.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZYLoading'
  s.version          = '0.1.0'
  s.summary          = 'A short description of ZYLoading.'


  s.homepage         = 'https://github.com/luzhiyongGit/ZYLoading'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'luzy' => 'luzy@2345.com' }
  s.source           = { :git => 'https://github.com/luzhiyongGit/ZYLoading.git', :tag => s.version.to_s }

  s.ios.deployment_target = '7.0'

  s.source_files = 'ZYLoading/Classes/**/*'
  
  s.resource_bundles = {
      'ZYLoading' => ['ZYLoading/Assets/*.png']
  }

  s.public_header_files = 'ZYLoading/Classes/**/*.h'
  s.frameworks = 'UIKit', 'CoreFoundation'
  s.dependency 'Masonry'
end
