Pod::Spec.new do |s|
  s.name             = 'yuli_ios'
  s.version          = '1.0.0'
  s.summary          = 'An iOS API for the Yuli app'
  s.homepage         = 'https://github.com/krisbitney/yuli_ios'
  s.license          = { :type => 'Proprietary', :text => 'All rights reserved. Do not distribute.' }
  s.author           = { 'Kris Bitney' => 'kristoferbitney@gmail.com' }
  s.source           = { :git => 'https://github.com/krisbitney/yuli_ios.git', :tag => s.version.to_s }
  s.platform     = :ios, '13.0'
  s.swift_version = '5.7'
  s.requires_arc = true
  s.static_framework = true

  s.source_files = 'Sources/yuli_ios/**/*.swift'

  s.vendored_frameworks = 'Frameworks/ComposableRequest.xcframework',
                           'Frameworks/ComposableStorage.xcframework',
                           'Frameworks/ComposableStorageCrypto.xcframework',
                           'Frameworks/KeychainAccess.xcframework',
                           'Frameworks/SwCrypt.xcframework',
                           'Frameworks/Swiftagram.xcframework',
                           'Frameworks/SwiftagramCrypto.xcframework'
end

