Pod::Spec.new do |s|
  s.name             = "UIImageView+Material"
  s.version          = "0.1.0"
  s.summary          = "An experimental UIImageView category for fade-in/fade-out images using the Material Design style."
  s.homepage         = "https://github.com/nklizhe/UIImageView-Material"
  s.license          = 'MIT'
  s.author           = { "Tom Li" => "nklizhe@gmail.com" }
  s.source           = { :git => "https://github.com/nklizhe/UIImageView-Material.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.public_header_files = 'Pod/Classes/**/*.h'
  s.dependency 'GPUImage', '~> 0.1.4'
end
