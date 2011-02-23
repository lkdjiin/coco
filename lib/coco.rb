$LOAD_PATH.unshift File.dirname(__FILE__)
$COCO_PATH = File.expand_path(File.dirname(__FILE__)) + '/..'
require 'coco/formatters'
require 'coco/coverage_stat'
require 'coco/coverage_result'
require 'coco/html_writers'
require 'coco/filename'
require 'coverage'

module Coco
end

Coverage.start

at_exit do
  result = Coco::CoverageResult.new(90).result(Coverage.result)
  puts Coco::ConsoleFormatter.new(result).format
  html_files = Coco::HtmlFormatter.new(result).format
  Coco::HtmlFilesWriter.new(html_files).write
  index = Coco::HtmlIndexFormatter.new(result).format
  Coco::HtmlIndexWriter.new(index).write
end
