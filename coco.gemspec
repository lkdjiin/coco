require 'rake'

Gem::Specification.new do |s|
  s.name = 'coco'
  s.version = File.read('VERSION').strip
  s.authors = ['Xavier Nayrac']
  s.email = 'xavier.nayrac@gmail.com'
  s.summary = 'Code coverage tool for ruby 2.x'
  s.homepage = 'http://lkdjiin.github.com/coco/'
  s.description = %q{"Code coverage tool for ruby 2.0 to 2.3.
Simply "require 'coco'" from rspec or unit/test.
Build simple html report.
Report sources that have no tests.
Configurable if you need to.}
	
  files = FileList['lib/**/*.rb', 'template/**/*', '[A-Z]*']
  files.exclude('TODO')
  s.files = files.to_a

  s.license = 'MIT'
  s.required_ruby_version = '>= 2.0'

  s.add_development_dependency 'bundler', '~> 1.11'
  s.add_development_dependency 'rspec', '~> 3.4'
  s.add_development_dependency 'cucumber'
  s.add_development_dependency 'rake'
end
