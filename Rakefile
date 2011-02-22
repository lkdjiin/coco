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
