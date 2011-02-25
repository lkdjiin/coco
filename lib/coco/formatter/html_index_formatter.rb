# -*- encoding: utf-8 -*-

require 'erb'

module Coco
  
  # I format the index.html
  class HtmlIndexFormatter < Formatter
    
    def initialize raw_coverages
      super(raw_coverages)
      @context = nil
      @template = Template.open File.join($COCO_PATH,'template/index.erb')
      @lines = []
      build_lines_for_context
    end
    
    def format
      @context = Context.new Helpers.index_title, @lines
      @template.result(@context.get_binding)
    end
    
    private
    
    def build_lines_for_context
      @raw_coverages.each do |filename, coverage| 
        filename = File.expand_path(filename)
        @lines << [CoverageStat.coverage_percent(coverage), filename, Helpers.rb2html(filename)]
      end
      # Sort by percentage
      @lines.sort_by! {|line| line[0]}
    end
    
  end

end
