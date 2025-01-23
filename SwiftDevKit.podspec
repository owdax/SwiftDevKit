Pod::Spec.new do |s|
  s.name             = 'SwiftDevKit'
  s.version          = '0.1.0-beta.1'
  s.summary          = 'A comprehensive Swift SDK providing developer tools and utilities'
  s.description      = <<-DESC
SwiftDevKit is your Swiss Army knife for Swift development, offering a wide range of functionalities:
- Text Processing and String Manipulation
- Time and TimeZone Utilities
- Color Conversion Tools
- Number Formatting
- Date Conversion
All designed with a focus on performance, safety, and ease of use.
                       DESC

  s.homepage         = 'https://github.com/owdax/SwiftDevKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'owdax' => 'dev@owdax.com' }
  s.source           = { :git => 'https://github.com/owdax/SwiftDevKit.git', :tag => "v#{s.version}" }
  s.social_media_url = 'https://twitter.com/owdax'

  s.ios.deployment_target = '16.0'
  s.osx.deployment_target = '13.0'
  s.tvos.deployment_target = '16.0'
  s.watchos.deployment_target = '9.0'
  
  s.swift_versions = ['6.0']
  
  s.source_files = 'Sources/SwiftDevKit/**/*'
  s.exclude_files = 'Sources/SwiftDevKit/Documentation.docc/**/*'
  
  s.resource_bundles = {
    'SwiftDevKit' => ['Sources/SwiftDevKit/Resources/**/*']
  }
  
  s.frameworks = 'Foundation'
  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'Tests/SwiftDevKitTests/**/*'
  end
  
  s.pod_target_xcconfig = { 
    'SWIFT_VERSION' => '6.0',
    'OTHER_SWIFT_FLAGS' => '-DSWIFT_STRICT_CONCURRENCY'
  }
end 