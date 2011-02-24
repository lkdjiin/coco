# -*- encoding: utf-8 -*-

$LOAD_PATH.unshift File.dirname(__FILE__)
$COCO_PATH = File.expand_path(File.expand_path(File.dirname(__FILE__)) + '/..')
require 'coco/formatters'
require 'coco/coverage_stat'
require 'coco/coverage_result'
require 'coco/html_writers'
require 'coco/helpers'
require 'coco/configuration'
require 'coco/source_lister'
require 'coverage'

module Coco
end

Coverage.start

at_exit do
  config = Coco::Configuration.new
  result = Coco::CoverageResult.new(config[:threeshold]).result(Coverage.result)
  puts Coco::ConsoleFormatter.new(result).format
  html_files = Coco::HtmlFormatter.new(result).format
  Coco::HtmlFilesWriter.new(html_files).write
  index = Coco::HtmlIndexFormatter.new(result).format
  Coco::HtmlIndexWriter.new(index).write
end
