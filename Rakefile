# -*- encoding: utf-8 -*-

require 'rake/dsl_definition'
require 'rake'
require 'rspec/core/rake_task'

def ruby_files_for_shell
  files = Dir.glob 'lib/**/*.rb'
  files.join(' ')
end

desc 'Test coco'
task :default => :spec

desc 'Test coco'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = ['--color --format documentation']
end

desc 'Check for code smells'
task :reek do
  puts 'Checking for code smells...'
  args = ruby_files_for_shell
  sh "reek --quiet #{args} | ./reek.sed"
end

desc 'Check for duplicate code'
task :flay do
  puts 'Check for duplicate code...'
  args = ruby_files_for_shell
  exec "flay #{args}"
end

desc 'Build the gem & install it'
task :install do
  sh "gem build coco.gemspec"
  f = FileList['coco*gem'].to_a
  sh "gem install #{f.first} --no-rdoc --no-ri"
end

desc 'Generate yard documentation for developpers'
task :doc do
  exec 'yardoc'
end
