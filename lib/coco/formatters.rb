module Coco
  
  # I format coverages information for console output
  class ConsoleFormatter
    
    # @param [Hash] raw_coverages The hash from Coverage.result
    def initialize raw_coverages
      @raw_coverages = raw_coverages
      @formatted_output = ''
    end
  
    def format 
      @raw_coverages.each do |filename, coverage|
        @formatted_output << "#{CoverageStat.coverage_percent coverage}% #{filename}\n"
      end
      @formatted_output
    end
    
  end
  
end
