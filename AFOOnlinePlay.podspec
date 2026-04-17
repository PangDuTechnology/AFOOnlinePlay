Pod::Spec.new do |s|
  s.name             = 'AFOOnlinePlay'
  s.version          = '0.0.1'
  s.summary          = 'AFO 在线播放模块'
  s.description      = '提供在线播放入口（输入链接 -> 播放）并作为 TabBar 子模块集成。'
  s.homepage         = 'https://example.local/AFOOnlinePlay'
  s.license          = { :type => 'MIT', :text => 'MIT' }
  s.author           = { 'AFO' => 'dev@local' }
  s.source           = { :path => '.' }

  s.ios.deployment_target = '13.0'
  s.requires_arc = true

  s.source_files = 'AFOOnlinePlay/**/*.{h,m}'
  s.public_header_files = 'AFOOnlinePlay/**/*.h'

  s.frameworks = 'UIKit', 'AVFoundation', 'AVKit'
end

