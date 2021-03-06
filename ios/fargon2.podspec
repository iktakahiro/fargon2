#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint fargon2.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'fargon2'
  s.version          = '0.0.1'
  s.summary          = 'A plugin for generating a hash based on Argon2 algorithm in Android / iOS platform.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'https://github.com/iktakahiro/fargon2'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Takahiro Ikeuchi' => 'takahiro.ikeuchi@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'CatCrypto'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
