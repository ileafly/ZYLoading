Pod::Spec.new do |s|
  s.name = 'ZYLoading'
  s.version = '0.1.0'
  s.summary = 'A short description of ZYLoading.'
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"luzy"=>"luzy@2345.com"}
  s.homepage = 'https://coding.net/u/ileafly/p/ZYLoading/git'
  s.frameworks = ["UIKit", "CoreFoundation"]
  s.source = -force

  s.ios.deployment_target    = '7.0'
  s.ios.preserve_paths       = 'ios/ZYLoading.framework'
  s.ios.public_header_files  = 'ios/ZYLoading.framework/Versions/A/Headers/*.h'
  s.ios.resource             = 'ios/ZYLoading.framework/Versions/A/Resources/**/*'
  s.ios.vendored_frameworks  = 'ios/ZYLoading.framework'
end
