require 'rake'

Gem::Specification.new do |s|
  s.name = 'coco'
  s.version = File.read('VERSION').strip
  s.authors = ['Xavier Nayrac']
  s.email = 'xavier.nayrac@gmail.com'
  s.summary = 'Code coverage tool for ruby 1.9.3 to 2.1'
  s.homepage = 'http://lkdjiin.github.com/coco/'
  s.description = %q{"Code coverage tool for ruby 1.9.3 to 2.1.
Use it by "require 'coco'" from rspec or unit/test.
It display names of uncovered files on console.
It builds simple html report.
It reports sources that have no tests.
It's configurable with a simple yaml file.}
	
	readmes = FileList.new('*') do |list|
		list.exclude(/(^|[^.a-z])[a-z]+/)
		list.exclude('TODO')
	end.to_a
  s.files = FileList['lib/**/*.rb', 'template/**/*', '[A-Z]*'].to_a + readmes
	s.license = 'GPL-3'
	s.required_ruby_version = '>= 1.9.3'
  s.add_development_dependency 'rspec', '~> 2.14'
  s.add_development_dependency 'rake', '>= 10.1.0'
  s.add_development_dependency 'reek', '~> 1.3'
  s.add_development_dependency 'flay', '~> 2.4'
  s.add_development_dependency 'yard-tomdoc'
end
