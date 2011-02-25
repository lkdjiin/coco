# -*- encoding: utf-8 -*-

module Coco

  # I format coverages information for console output
  class ConsoleFormatter < Formatter
    
    # @param [Hash] covered
    # @param [Array] uncovered
    def initialize covered, uncovered
      super(covered, uncovered)
      @formatted_output = []
    end
  
    # return [string] percent covered and associated filenames 
    def format 
      @raw_coverages.each do |filename, coverage| 
        @formatted_output << [CoverageStat.coverage_percent(coverage), filename]
      end
      @uncovered.each do |filename|
        @formatted_output << [0, filename]
      end
      @formatted_output.sort!
      @formatted_output.map! {|elem| "#{elem[0]}% #{elem[1]}"}
      @formatted_output.join("\n")
    end
    
  end

end
