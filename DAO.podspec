#
#  Be sure to run `pod spec lint EZFoundation.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name          = 'DAO'
  spec.version       = '1.0'
  spec.summary       = 'Swift 轻量数据库实现'

  spec.homepage      = 'https://github.com/Ezreal2852'
  spec.license       = 'MIT'
  spec.author        = { 'Ezreal' => '544881532@qq.com' }

  spec.source        = { git: 'https://github.com/Ezreal2852/DAO.git', tag: 'v' + spec.version.to_s }
  spec.source_files  = 'Source/*.swift'

  spec.platform      = :ios, '10.0'
  spec.swift_version = '5.0'

  spec.framework     = 'Foundation'
  spec.ios.dependency 'HandyJSON', '~> 5.0.1'
  spec.ios.dependency 'YTKKeyValueStore', '0.1.2'
end
