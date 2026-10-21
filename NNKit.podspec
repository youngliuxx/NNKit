#
# Be sure to run `pod lib lint NNKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NNKit'
  s.version          = '1.1.1'
  s.summary          = 'Leigod NNKit Tools'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/ly/NNKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'nn' => 'nn.com' }
  s.source           = { :git => 'http://git.leigod.top/root/nnkit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'
  
  s.prefix_header_contents = '
  # if __has_include(<NNKit/NNKit-Swift.h>)
      #import <NNKit/NNKit-Swift.h>
  #else
      #import NNKit-Swift.h"
  #endif
  '

  s.subspec 'Classes' do |ss|
    #ss.source_files = 'NNKit/Classes/**/*'
    ss.subspec 'Base' do |sss|
      sss.source_files = 'NNKit/Classes/Base/**/*'
    end
    ss.subspec 'Extensions' do |sss|
      sss.source_files = 'NNKit/Classes/Extensions/**/*'
    end
    ss.subspec 'Shared' do |sss|
      sss.source_files = 'NNKit/Classes/Shared/**/*'
    end
    ss.subspec 'Utils' do |sss|
      sss.source_files = 'NNKit/Classes/Utils/**/*'
    end
    ss.subspec 'Views' do |sss|
      sss.source_files = 'NNKit/Classes/Views/**/*'
    end
    ss.subspec 'OCFiles' do |sss|
      sss.source_files = 'NNKit/Classes/OCFiles/**/*'
    end
  end
  
  s.subspec 'Assets' do |ss|
    ss.resource = 'NNKit/Assets/NNKitBundle.bundle'
  end
  
  s.static_framework = true
  #s.source_files = 'NNKit/Classes/**/*'
  
  #s.resource_bundles = {
  #   'NNKit' => ['NNKit/Assets/*.png'],
  #   'NNKit' => ['NNKit/Assets/*.json'],
  #   'NNKitBundle' => ['NNKit/Assets/NNKitBundle.bundle']
  # }

  #s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'SnapKit'
  s.dependency 'BRPickerView'
  s.dependency 'PanModal'
  s.dependency 'RxSwift'
  s.dependency 'RxSwiftExt'
  s.dependency 'RxCocoa'
  s.dependency 'YYText', '~> 1.0.7'
end
