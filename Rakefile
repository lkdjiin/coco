# -*- encoding: utf-8 -*-

require 'rake'
require 'rspec/core/rake_task'

desc 'Test coco'
task :default => :spec

desc 'Test coco'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = ['--color']
end

desc 'Check for code smells'
task :reek do
  puts 'Checking for code smells...'
  files = Dir.glob 'lib/**/*.rb'
  args = files.join(' ')
  sh "reek --quiet #{args} | ./reek.sed"
end

desc 'Build the gem & install it'
task :install do
  sh "gem build coco.gemspec"
	f = FileList['coco*gem'].to_a
	sh "gem install #{f.first} --no-rdoc --no-ri"
end

desc 'Generate yard documentation for developpers'
task :doc do 
	exec 'yardoc --title "Coco Documentation" - NEWS COPYING VERSION'
end
