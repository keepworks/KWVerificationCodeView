Pod::Spec.new do |s|
  s.name             = 'KWVerificationCodeView'
  s.version          = '0.1.0'
  s.summary          = 'A subclass on UIView that displays a verification code field.'
  s.description      = 'This CocoaPod provides the ability to use a UIView that can display a verification field.'
  s.homepage         = 'https://bitbucket.org/keepworks/kwverificationcodeview'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'KeepWorks' => 'ios@keepworks.com' }
  s.source           = { :git => 'https://bitbucket.org/keepworks/kwverificationcodeview.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.source_files = 'KWVerificationCodeView/Classes/**/*'
end
