Pod::Spec.new do |spec|
  spec.name         = "YLKit"
  spec.version      = "1.0.1"
  spec.summary      = "A short description of YLKit."
  spec.swift_version='5.0'
  spec.requires_arc = true
  spec.description  = <<-DESC
                    swift常用扩展类集合，包含自定义一些常用组件
                   DESC
  spec.homepage     = "https://github.com/jianghat/YLKit.git"
  spec.license      = { :type =>"MIT", :file => "License" }
  spec.author             = { "jiangshiquan" => "549488710@qq.com" }
  spec.platform     = :ios, "9.0"
  spec.source       = { :git => "https://github.com/jianghat/YLKit.git", :tag => spec.version }
  spec.source_files  = "YLKit/**/*.{swift}"
  spec.framework  = "UIKit","Foundation"
  spec.dependency 'MJRefresh'
  spec.dependency 'SnapKit'
  spec.dependency 'YYKit'
  
end
