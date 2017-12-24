Pod::Spec.new do |s|
  s.name = 'DocumentClassifier'
  s.version = '0.9.0'
  s.license = 'MIT'
  s.summary = 'Swift framework for document classification using a Core ML model.'
  s.homepage = 'https://github.com/toddkramer/DocumentClassifier'
  s.social_media_url = 'http://twitter.com/_toddkramer'
  s.author = 'Todd Kramer'
  s.source = { :git => 'https://github.com/toddkramer/DocumentClassifier.git', :tag => s.version }

  s.module_name = 'DocumentClassifier'
  s.ios.deployment_target = '11.0'
  s.osx.deployment_target = '10.13'
  s.tvos.deployment_target = '11.0'
  s.watchos.deployment_target = '4.0'

  s.source_files = 'Sources/*.{swift,mlmodel}'
end
