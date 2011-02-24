# -*- encoding: utf-8 -*-

require 'erb'
require 'fileutils'

module Coco
  
  # My childs will format coverages information.
  # @abstract
  class Formatter
    # @param [Hash] raw_coverages The hash from Coverage.result
    def initialize raw_coverages
      @raw_coverages = raw_coverages
    end
    
    def format
      "Implement me in child"
    end
  end
  
  # I format coverages information for console output
  class ConsoleFormatter < Formatter
    
    def initialize raw_coverages
      super(raw_coverages)
      @formatted_output = []
    end
  
    # return [string] percent covered and associated filenames 
    def format 
      @raw_coverages.each do |filename, coverage| 
        @formatted_output << "#{CoverageStat.coverage_percent(coverage)}% #{filename}"
      end
      @formatted_output.sort_by {|line| line =~ /^\d+/}.join("\n")
    end
    
  end
  
  # I format coverages information into html files.
  class HtmlFormatter < Formatter
    
    def initialize raw_coverages
      super(raw_coverages)
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
    
    def build_html filename, coverage
      source = File.readlines filename
      lines = []
      source.each_with_index do |line, index|
        lines << [index+1, line.chomp, coverage[index]]
      end
      @context = Context.new filename, lines
      @formatted_output_files[filename] = @template.result(@context.get_binding)
    end
    
  end
  
  # I format the index.html
  class HtmlIndexFormatter < Formatter
    
    def initialize raw_coverages
      super(raw_coverages)
      @context = nil
      @formatted_output = ''
      @template = Template.open File.join($COCO_PATH,'template/index.erb')
    end
    
    def format
      @context = Context.new Helpers.index_title, build_lines_for_context
      @template.result(@context.get_binding)
    end
    
    private
    
    def build_lines_for_context
      lines = []
      @raw_coverages.each do |filename, coverage| 
        filename = File.expand_path(filename)
        lines << [CoverageStat.coverage_percent(coverage), filename, Helpers.rb2html(filename)]
      end
      # Sort by percentage
      lines.sort_by {|line| line[0]}
    end
    
  end
  
  # Contextual information for ERB template.
  class Context
  
    # @param [String] filename Name of the source file
    # @param [Array] lines 
		def initialize filename, lines
			@filename = filename
      @lines = lines
		end
		
		def get_binding
			binding
		end
	end
  
  # From me, you can obtain ERB templates.
  class Template
    # @param [String] filename An ERB template
    # @return [ERB]
    def self.open filename
      io = IO.readlines(filename, nil)
			return ERB.new(io[0], nil, '><')
    end
  end

end
