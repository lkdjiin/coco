$LOAD_PATH.unshift File.dirname(__FILE__)
require 'coco/formatters'
require 'coco/coverage_stat'
require 'coverage'

module Coco
end

Coverage.start

at_exit do
  here = Dir.pwd
  result = Coverage.result.select {|key, value| key.start_with? here}
  formatter = Coco::ConsoleFormatter.new result
  puts formatter.format
end
