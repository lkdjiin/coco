require 'erb'

module Coco

  # I format the index.html
  #
  class HtmlIndexFormatter < Formatter

    def initialize(raw_coverages, uncovered, result, threshold = 100)
      super(raw_coverages, uncovered)
      @result = result
      @threshold = threshold
      @summary = Summary.new(result)
      @context = nil
      @template = Template.open(File.join(Coco::ROOT, 'template/index.erb'))
      @lines = []
      build_lines_for_context
    end

    def format
      @context = IndexContext.new(Helpers.index_title, @lines, uncovered_files,
                                  @summary, @threshold)
      @template.result(@context.variables)
    end

    private

    def build_lines_for_context
      # @raw_coverages.each do |filename, coverage|
      @result.coverable_files.to_a.each do |filename, coverage|
        @lines << build_line(filename, coverage)
      end
      @lines.sort!
    end

    def build_line(filename, coverage)
      [
        CoverageStat.coverage_percent(coverage),
        Helpers.name_for_html(filename),
        Helpers.rb2html(filename),
      ]
    end

    def uncovered_files
      @uncovered.map { |filename| Helpers.name_for_html(filename) }
    end
  end
end
