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
  t.rspec_opts = ['--color --order=random']
end

desc 'Check for code smells with reek'
task :reek do
  puts 'Checking for code smells.'
  puts '-------------------------'
  system "reek #{ruby_files_for_shell}"
end

desc 'Check for duplicate code with flay'
task :flay do
  puts 'Checking for duplicate code.'
  puts '----------------------------'
  exec "flay lib"
end

desc 'Check various code metrics'
task :metrics do
  puts 'Checking various metrics.'
  puts '========================='
  Rake::Task['reek'].execute
  Rake::Task['flay'].execute
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
