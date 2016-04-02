require 'coco/theme'
require 'coco/formatter'
require 'coco/cover'
require 'coco/writer'
require 'coco/helpers'
require 'coco/configuration'
require 'coco/lister'

require 'coverage'

# Public: Main namespace of Coco, a code coverage utilily for
# Ruby from 2.0 to 2.3.
#
module Coco
	ROOT = File.expand_path(File.dirname(__FILE__) + '/..').freeze
end

Coverage.start

at_exit do
  config = Coco::Configuration.new
  if config.run_anytime?
    result = Coco::CoverageResult.new(config, Coverage.result)
    covered = result.not_covered_enough

    sources = Coco::SourceLister.new(config).list
    uncovered = Coco::UncoveredLister.new(sources, result.coverable_files).list

    console_formatter = Coco::ConsoleFormatter.new(covered,
                                                   uncovered,
                                                   config[:threshold],
                                                   result,
                                                   config)
    puts console_formatter.format
    puts console_formatter.link if config[:show_link_in_terminal]

    html_files = Coco::HtmlFormatter.new(covered).format
    Coco::HtmlFilesWriter.new(html_files, config[:theme]).write

    index = Coco::HtmlIndexFormatter.new(covered, uncovered, result).format
    Coco::HtmlIndexWriter.new(index).write
  end
end
