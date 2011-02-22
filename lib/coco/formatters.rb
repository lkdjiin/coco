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
  
end
