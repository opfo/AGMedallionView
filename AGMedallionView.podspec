Pod::Spec.new do |s|
  s.name         = "AGMedallionView"
  s.version      = "1.2.0"
  s.summary      = "AGMedallionView is a picture view control just like the one that Apple is using at the login screen in Mac OS X Lion."
  s.homepage     = "https://github.com/opfo/AGMedallionView.git"
  s.license      = 'MIT'
  s.author       = { "Artur Grigor" => "arturgrigor@gmail.com" }
  s.source       = { :git => "https://github.com/opfo/AGMedallionView.git", :tag => s.version.to_s }
  s.platform     = :ios
  s.source_files = 'Classes/*.{h,m}'
  s.frameworks    = 'CoreGraphics'
  s.requires_arc = true
end