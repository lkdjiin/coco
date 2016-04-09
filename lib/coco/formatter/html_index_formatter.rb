require 'erb'

module Coco

  # I format the index.html
  #
  class HtmlIndexFormatter

    # uncovered - An Array list of uncovered files.
    # result    - CoverageResult.
    # threshold - Fixnum.
    #
    def initialize(uncovered, result, threshold = 100)
      @uncovered = uncovered
      @result = result
      @threshold = threshold
      @summary = Summary.new(result, uncovered)
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
      @result.coverable_files.to_a.each do |filename, coverage|
        @lines << IndexLine.build(filename, coverage)
      end
      @lines.sort!
    end

    def uncovered_files
      @uncovered.map { |filename| Helpers.name_for_html(filename) }
    end
  end
end
