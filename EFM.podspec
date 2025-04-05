Pod::Spec.new do |s|

  s.name = 'EFM'
  s.version = '1.0.0'
  s.license = { :type => 'MIT', :file => 'LICENSE.md' } #see another type of licence beside 'MIT' licence
  s.summary = 'Essential Feed platform agnostic module'
  s.homepage = 'https://github.com/denickman/EssentialFeedPOD'
  s.authors = { 'Essential Develoer' => 'author@email.com'}
  #s.source = { :git => 'https://github.com/denickman/EFM.git', :branch => 'main' }
  s.source = { :git => 'https://github.com/denickman/EssentialFeedPOD.git', :tag => "#{s.version}" }

  s.source_files = 'EFM/**/*.swift'
  s.resources = [
    'EFM/**/*.xcdatamodeld',
    'EFM/**/*.lproj'
  ]

  s.swift_versions = ['5']
  s.ios.deployment_target = '18.0' # build settings - iOS deployment target
  s.osx.deployment_target = '14.0' # build settings - macOS deployment target
  s.framework = 'CoreData'
  # s.dependency 'Alamofire'

end
