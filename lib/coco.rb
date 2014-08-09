# -*- encoding: utf-8 -*-

require 'coco/formatter'
require 'coco/cover'
require 'coco/writer'
require 'coco/helpers'
require 'coco/configuration'
require 'coco/lister'

require 'coverage'

# Public: Main namespace of Coco, a code coverage utilily for
# Ruby from 1.9.3 to 2.1.
module Coco
	ROOT = File.expand_path(File.dirname(__FILE__) + '/..').freeze
end

Coverage.start

at_exit do
  config = Coco::Configuration.new
  if config.user_wants_to_run?
    result = Coco::CoverageResult.new(config, Coverage.result)
    covered = result.covered_from_domain

    sources = Coco::SourceLister.new(config).list
    uncovered = Coco::UncoveredLister.new(sources, result.all_from_domain).list

    console_formatter = Coco::ConsoleFormatter.new(covered, uncovered,
                                                   config[:threshold])
    puts console_formatter.format(config[:single_line_report])
    puts console_formatter.link if config[:show_link_in_terminal]

    html_files = Coco::HtmlFormatter.new(covered).format
    Coco::HtmlFilesWriter.new(html_files).write

    index = Coco::HtmlIndexFormatter.new(covered, uncovered).format
    Coco::HtmlIndexWriter.new(index).write
  end
end
