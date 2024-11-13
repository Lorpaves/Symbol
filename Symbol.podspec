Pod::Spec.new do |spec|
  spec.name         = 'Symbol'
  spec.version      = '0.0.1'
  spec.summary      = 'Define image constants made easy.'
  spec.description  = <<-DESC
  Symbol provides several macros to generate SwiftUI's Image, UIKit's UIImage and AppKit's NSImage by defining a static string constant.
  Symbol supports both SFSymbol and Assets.
  By using @AssetImageCollection with a struct, it will generate a collection of images in the assets.
  By using @SFSymbolCollection with a struct, it will generate a collection of sfsymbol images.
  Using Symbol for better managing your project's images.
                   DESC
  spec.homepage     = 'https://github.com/Lorpaves/Symbol'

  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.author             = { 'Lorpaves' => '986298194@qq.com' }

  spec.ios.deployment_target = '12.0'
  spec.osx.deployment_target = '10.13'

  spec.swift_version = '5.0'

  spec.source       = { :git => 'https://github.com/Lorpaves/Symbol.git', :tag => "v#{spec.version}" }
  spec.source_files  = "Sources/Symbol/**/*.{c,h,m,swift}"
  
  spec.prepare_command = 'swift build -c release && cp -f .build/release/SymbolMacros-tool ./Binary/SymbolMacros'
  
  spec.pod_target_xcconfig = {
    'OTHER_SWIFT_FLAGS' => [
      '-load-plugin-executable ${PODS_ROOT}/Symbol/Binary/SymbolMacros#SymbolMacros'
    ]
  }
  spec.user_target_xcconfig = {
    'OTHER_SWIFT_FLAGS' => [
      '-load-plugin-executable ${PODS_ROOT}/Symbol/Binary/SymbolMacros#SymbolMacros'
    ]
  }
  
  spec.requires_arc = true
end
