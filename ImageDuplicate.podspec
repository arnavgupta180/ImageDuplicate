#
# Be sure to run `pod lib lint ImageDuplicate.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ImageDuplicate'
  s.version          = '0.1.5'
  s.swift_version = '5.0'

  s.summary          = 'Elegant developer tool to find image duplicates'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
 ImageDuplicateFinder is a developer tool to find duplicate images. Your duplicate images can be images having same data or same images present in different bundles. It will give you paths of that images.This will reduce the app size of the app as well
                       DESC

  s.homepage         = 'https://github.com/arnavgupta180/ImageDuplicate'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'arnavgupta180' => 'arnavgupta180@gmail.com' }
  s.source           = { :git => 'https://github.com/arnavgupta180/ImageDuplicate.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'Source/**/*'
  
  # s.resource_bundles = {
  #   'ImageDuplicate' => ['ImageDuplicate/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
