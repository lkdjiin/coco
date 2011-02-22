require 'fileutils'

module Coco
  
  # I format coverages information for console output
  class ConsoleFormatter
    
    # @param [Hash] raw_coverages The hash from Coverage.result
    def initialize raw_coverages
      @raw_coverages = raw_coverages
      @formatted_output = ''
      @threeshold = 90
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
  
  class HtmlFormatter
    
    # @param [Hash] raw_coverages The hash from Coverage.result
    def initialize raw_coverages
      @raw_coverages = raw_coverages
      @formatted_output = ''
      @threeshold = 90
      @context = Context.new
      FileUtils.makedirs 'coverage'
      FileUtils.copy File.join($COCO_PATH, 'template/coco.css'), 'coverage'
    end
    
    def format
      template = get_template File.join($COCO_PATH,'template/file.erb')
      @raw_coverages.map do |filename, coverage|
        @context.filename = filename
        source = File.readlines filename
        lines = []
        source.each_with_index do |line, index|
          lines << [index+1, line.chomp, coverage[index]]
        end
        @context.lines = lines
        html = template.result(@context.get_binding)
        f = File.new(File.join('coverage', File.basename(filename) + '.html'), "w")
        f.write html
        f.close
      end
    end
    
    def get_binding
			binding
		end
    
    private
    
    def get_template filename
			io = IO.readlines(filename, nil)
			return ERB.new(io[0], nil, '><')
		end
  end
  
  class Context
    attr_accessor :filename, :lines
		def initialize
			@filename = 'no filename'
      @lines = []
		end
		
		def get_binding
			binding
		end

	end

end
