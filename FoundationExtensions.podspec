Pod::Spec.new do |s|
  s.name         = "FoundationExtensions"
  s.version      = "1.0.5"
  s.summary      = "Some Extensions Categories for Foundation framework"
  s.homepage     = "https://github.com/Tinghui/FoundationExtensions"
  s.license      = 'MIT'
  s.author       = { 'Tinghui' => 'tinghui.zhang3@gmail.com' }
  s.platform     = :ios, '7.0'
  s.source       = { :git => "https://github.com/Tinghui/FoundationExtensions.git", :tag => s.version }
  s.requires_arc = true
  s.source_files = 'FoundationExtensions/*.{h,m}'
  s.framework    = 'Foundation'
end
