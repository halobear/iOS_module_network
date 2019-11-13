Pod::Spec.new do |s|
  s.name         = "iOS_module_network"
  s.version      = "1.0.0"
  s.summary      = "幻熊网络加载工具"
  s.homepage     = "https://github.com/halobear/iOS_module_network.git"
  s.license      = "MIT"
  s.author       = { "FuYe" => "834225691@qq.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/halobear/iOS_module_network.git", :tag => "#{s.version}" }
  s.requires_arc = true
  s.source_files = "HBNetwork/*.{h,m}"
  s.framework = "CFNetwork"
  s.dependency "AFNetworking/NSURLSession", "~> 3.0"
  s.dependency "YYModel"
end
