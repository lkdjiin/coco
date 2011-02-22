require 'erb'
require 'fileutils'

module Coco
  
  # @abstract
  class Formatter
    # @param [Hash] raw_coverages The hash from Coverage.result
    def initialize raw_coverages
      @raw_coverages = raw_coverages
      @threeshold = 90
    end
    
    def format
      "Please implement me in a child!"
    end
  end
  
  # I format coverages information for console output
  class ConsoleFormatter < Formatter
    
    def initialize raw_coverages
      super(raw_coverages)
      @formatted_output = ''
    end
  
    # return [string] percent covered and associated filenames 
    #   if percent < threeshold (default 90%)
    def format 
      @raw_coverages.each do |filename, coverage|
        percent = CoverageStat.coverage_percent coverage
        @formatted_output << "#{percent}% #{filename}\n" if percent < @threeshold
      end
      @formatted_output
    end
    
  end
  
  # I format coverages information into html files.
  class HtmlFormatter < Formatter
    
    def initialize raw_coverages
      super(raw_coverages)
      @formatted_output_files = {}
      @context = Context.new
    end
    
    def format
      template = Template.open File.join($COCO_PATH,'template/file.erb')
      @raw_coverages.map do |filename, coverage|
        percent = CoverageStat.coverage_percent coverage
        if percent < @threeshold
          @context.filename = filename
          source = File.readlines filename
          lines = []
          source.each_with_index do |line, index|
            lines << [index+1, line.chomp, coverage[index]]
          end
          @context.lines = lines
          
          @formatted_output_files[filename] = template.result(@context.get_binding)
        end
      end
      @formatted_output_files
    end
    
  end
  
  # Contextual information for ERB template.
  class Context
    # Name of the source file
    attr_accessor :filename
    # Array of lines description (a line is : [num, text, hit])
    attr_accessor :lines
    
		def initialize
			@filename = 'no filename'
      @lines = []
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
