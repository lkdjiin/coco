require 'cgi'
require 'erb'

module Coco
  
  # I format coverages information into html files.
  # @todo document and change name to HtmlFilesFormatter
  class HtmlFormatter < Formatter
    
    def initialize(raw_coverages)
      super(raw_coverages, [])
      @formatted_output_files = {}
      @context = nil
      @template = Template.open File.join($COCO_PATH,'template/file.erb')
    end
    
    def format
      @raw_coverages.each do |filename, coverage|
        build_html filename, coverage
      end
      @formatted_output_files
    end
    
    private
    
    def build_html(filename, coverage)
      source = File.readlines filename
      lines = []
      source.each_with_index do |line, index|
        lines << [index+1, CGI.escapeHTML(line.chomp), coverage[index]]
      end
      @context = Context.new filename, lines
      @formatted_output_files[filename] = @template.result(@context.get_binding)
    end
    
  end

end
