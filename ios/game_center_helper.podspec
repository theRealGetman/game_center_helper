#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint game_center_helper.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'game_center_helper'
  s.version          = '0.1.0'
  s.summary          = 'A Flutter package for integrating Game Center authentication.'
  s.description      = <<-DESC
A Flutter package for integrating Game Center authentication.
                       DESC
  s.homepage         = 'https://github.com/theRealGetman/game_center_helper'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Artem Getman' => 'a.e.getman@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  # If your plugin requires a privacy manifest, for example if it uses any
  # required reason APIs, update the PrivacyInfo.xcprivacy file to describe your
  # plugin's privacy impact, and then uncomment this line. For more information,
  # see https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
  # s.resource_bundles = {'game_center_helper_privacy' => ['Resources/PrivacyInfo.xcprivacy']}
end
