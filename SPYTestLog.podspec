Pod::Spec.new do |spec|
  spec.name = 'SPYTestLog'
  spec.version = '0.0.1'
  spec.authors = {'Scott Petit' => 'petit.scott@gmail.com'}
  spec.homepage = 'https://github.com/ScottPetit/'
  spec.summary = 'XcodeColors meets XCTest'
  spec.source = {:git => 'git@github.com:ScottPetit/SPYTestLog.git', :tag => "v#{spec.version}"}
  spec.license = { :type => 'MIT', :file => 'LICENSE' }

  spec.platform = :ios
  spec.requires_arc = true
  spec.frameworks = 'XCTest'
  spec.source_files = 'SPYTestLog/'
end
