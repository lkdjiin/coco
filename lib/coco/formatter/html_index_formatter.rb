require 'erb'

module Coco

  # I format the index.html
  class HtmlIndexFormatter < Formatter

    def initialize(raw_coverages, uncovered)
      super
      @context = nil
      @template = Template.open(File.join(Coco::ROOT, 'template/index.erb'))
      @lines = []
      build_lines_for_context
    end

    def format
      @context = IndexContext.new(
        Helpers.index_title,
        @lines,
        @uncovered.map {|filename| Helpers.name_for_html(filename) })
      @template.result(@context.get_binding)
    end

    private

    def build_lines_for_context
      @raw_coverages.each do |filename, coverage|
        @lines << [
          CoverageStat.coverage_percent(coverage),
          Helpers.name_for_html(filename),
          Helpers.rb2html(filename)
        ]
      end
      @lines.sort!
    end

  end

end
