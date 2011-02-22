# -*- encoding: utf-8 -*-

require 'rake'

Gem::Specification.new do |s|
  s.name = 'coco'
  s.version = File.read('VERSION').strip
  s.authors = ['Xavier Nayrac']
  s.email = 'xavier.nayrac@gmail.com'
  s.summary = 'Code coverage tool.'
  #s.homepage = 'https://github.com/lkdjiin/coco/wiki'
  s.description = %q{"Code coverage tool.}
	
	readmes = FileList.new('*') do |list|
		list.exclude(/(^|[^.a-z])[a-z]+/)
		list.exclude('TODO')
	end.to_a
  s.files = FileList['lib/**/*.rb', 'template/*', '[A-Z]*'].to_a + readmes
	s.license = 'GPL-3'
	s.required_ruby_version = '>= 1.9.2'
end
