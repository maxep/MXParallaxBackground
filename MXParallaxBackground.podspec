Pod::Spec.new do |s|
  s.name             = "MXParallaxBackground"
  s.version          = "1.0.0"
  s.summary          = "MXParallaxBackground is a simple background class for UIScrolView."
 
  s.description      = <<-DESC
                        MXParallaxBackground is a simple background class for UIScrolView.
                        You can add as many backgrounds as you want with different intensity and direction.
                       DESC

  s.homepage         = "https://github.com/maxep/MXParallaxBackground"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Maxime Epain" => "maime.epain@gmail.com" }
  s.source           = { :git => "https://github.com/maxep/MXParallaxBackground.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/MaximeEpain'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'MXParallaxBackground/**/*'

end
