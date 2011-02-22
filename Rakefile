require 'rake'
require 'rspec/core/rake_task'

desc 'Test coco'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = ['--color', '--format documentation']
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
