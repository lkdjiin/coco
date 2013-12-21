# -*- encoding: utf-8 -*-

require 'erb'

module Coco
  
  # I format the index.html
  class HtmlIndexFormatter < Formatter
    
    def initialize(raw_coverages, uncovered)
      super(raw_coverages, uncovered)
      @context = nil
      @template = Template.open File.join($COCO_PATH,'template/index.erb')
      @lines = []
      build_lines_for_context
    end
    
    def format
      @context = IndexContext.new(Helpers.index_title, @lines,
                                  @uncovered.map{|e| emphasize(e)})
      @template.result(@context.get_binding)
    end
    
    private
    
    def build_lines_for_context
      @raw_coverages.each do |filename, coverage| 
        filename = File.expand_path(filename)
        percentage = CoverageStat.coverage_percent(coverage)
        on_disk_filename = Helpers.rb2html(filename)
        @lines << [percentage, emphasize(filename), on_disk_filename]
      end
      @lines.sort!
    end
    
    def emphasize(filename)
      base = File.basename filename
      filename.sub(base, "<b>#{base}</b>")
    end
    
  end

end
