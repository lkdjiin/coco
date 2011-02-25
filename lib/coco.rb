# -*- encoding: utf-8 -*-

$LOAD_PATH.unshift File.dirname(__FILE__)
$COCO_PATH = File.expand_path(File.expand_path(File.dirname(__FILE__)) + '/..')
require 'coco/formatter'
require 'coco/cover'
require 'coco/writer'
require 'coco/helpers'
require 'coco/configuration'
require 'coco/lister'
require 'coverage'

module Coco
end

Coverage.start

at_exit do
  config = Coco::Configuration.new
  result = Coco::CoverageResult.new(config[:threeshold], Coverage.result)
  covered = result.covered_from_domain
  
  sources = Coco::SourceLister.new(config[:directories]).list
  uncovered = Coco::UncoveredLister.new(sources, result.all_from_domain).list
  
  puts Coco::ConsoleFormatter.new(covered, uncovered).format
  
  html_files = Coco::HtmlFormatter.new(covered).format
  Coco::HtmlFilesWriter.new(html_files).write
  
  index = Coco::HtmlIndexFormatter.new(covered, uncovered).format
  Coco::HtmlIndexWriter.new(index).write
end
