# -*- encoding: utf-8 -*-

module Coco

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

end
