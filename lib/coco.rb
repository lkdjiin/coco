$LOAD_PATH.unshift File.dirname(__FILE__)
$COCO_PATH = File.expand_path(File.dirname(__FILE__)) + '/..'
require 'coco/formatters'
require 'coco/coverage_stat'
require 'coverage'
require 'erb'

module Coco

  def Coco.exclude_external_sources(raw_coverage_result)
    here = Dir.pwd
    raw_coverage_result.select {|key, value| key.start_with? here}
  end
  
end

Coverage.start

at_exit do
  result = Coco.exclude_external_sources(Coverage.result)
  puts Coco::ConsoleFormatter.new(result).format
  Coco::HtmlFormatter.new(result).format
end
