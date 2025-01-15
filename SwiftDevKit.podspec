Pod::Spec.new do |s|
  s.name             = 'SwiftDevKit'
  s.version          = '0.1.0'
  s.summary          = 'A comprehensive Swift SDK for developers - your Swiss Army knife for Swift development.'

  s.description      = <<-DESC
SwiftDevKit provides an extensive collection of developer utilities with a focus on performance,
ease of use, and Swift-first design. It brings the power of web-based developer tools natively to Swift.
                       DESC

  s.homepage         = 'https://github.com/owdax/SwiftDevKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'owdax' => 'github.com/owdax' }
  s.source           = { :git => 'https://github.com/owdax/SwiftDevKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.osx.deployment_target = '10.15'
  s.tvos.deployment_target = '13.0'
  s.watchos.deployment_target = '6.0'
  
  s.swift_version = '5.9'
  s.source_files = 'Sources/**/*'
  
  # Dependencies will be added here as needed
  # s.dependency 'SomePackage'
  
  # Any resources will be added here
  # s.resource_bundles = {
  #   'SwiftDevKit' => ['Sources/Resources/**/*']
  # }
end 