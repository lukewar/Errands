Pod::Spec.new do |s|
  s.name         = "Errands"
  s.version      = "0.0.1"
  s.source       = { :git => "https://github.com/lukewar/Errands.git", :tag => "#{s.version}" }
  s.summary      = "A nice way of running sequential tasks."
  s.description  = "µ-library with aim on simplyfing asynchronous sequential operations."
  s.homepage     = "https://github.com/lukewar/Errands"
  s.license      = {:type => "Attribution", :file => "LICENSE"}
  s.authors      = {'Lukasz Warchol' => 'lwarchol87@gmail.com'}
  s.social_media_url   = "https://twitter.com/warcholuke"
  s.cocoapods_version = '>= 1.5.0'
  s.swift_version = "4.1"
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"
  s.source_files  = "Errands/**/*.swift"
  s.requires_arc = true
end
