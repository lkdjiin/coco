require 'cgi'
require 'erb'

module Coco

  # I format coverage's data into html files.
  #
  class HtmlFormatter

    def initialize(raw_coverages)
      @raw_coverages = raw_coverages
      @formatted_output_files = {}
      @context = nil
      @template = Template.open(File.join(Coco::ROOT, 'template/file.erb'))
    end

    def format
      @raw_coverages.each do |filename, coverage|
        build_html(filename, coverage)
      end
      @formatted_output_files
    end

    private

    def build_html(filename, coverage)
      lines = []
      File.readlines(filename).each_with_index do |line, index|
        lines << [index + 1, CGI.escapeHTML(line.chomp), coverage[index]]
      end
      @context = Context.new(Helpers.name_for_html(filename), lines)
      @formatted_output_files[filename] = @template.result(@context.variables)
    end
  end
end
