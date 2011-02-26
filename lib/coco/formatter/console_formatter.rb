# -*- encoding: utf-8 -*-

module Coco

  # I format coverages information for console output
  class ConsoleFormatter < Formatter
    
    # return [string] percent covered and associated filenames 
    def format 
      @formatted_output.join("\n")
    end
    
    # @param [Hash] covered
    # @param [Array] uncovered
    def initialize covered, uncovered
      super(covered, uncovered)
      @formatted_output = []
      compute_percentage
      add_percentage_to_uncovered
      @formatted_output.sort!
      @formatted_output.map! do |percentage, filename| 
        text = ColoredString.new "#{percentage}% #{filename}"
        if percentage <= 50
          text.red
        else
          text.yellow
        end
      end
    end
  
    private
    
    def compute_percentage
      @raw_coverages.each do |filename, coverage| 
        percentage = CoverageStat.coverage_percent(coverage)
        @formatted_output << [percentage, filename]
      end
    end
    
    def add_percentage_to_uncovered
      @uncovered.each do |filename| @formatted_output << [0, filename] end
    end
    
  end

end
