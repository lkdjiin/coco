require 'bundler/gem_tasks'
require 'rake/dsl_definition'
require 'rake'
require 'rspec/core/rake_task'

desc 'Test with all tools'
task :default => :all_tests

desc 'Test with RSpec'
RSpec::Core::RakeTask.new(:rspec) do |t|
  t.rspec_opts = ['--color --order=random']
end

desc 'Test with Cucumber'
task :cucumber do
  exec 'cucumber'
end

task :all_tests do
  Rake::Task['rspec'].execute
  Rake::Task['cucumber'].execute
end


