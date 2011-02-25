# -*- encoding: utf-8 -*-

module Coco

  # Compute results of interest from the big results information (from Coverage.result)
  class CoverageResult
    attr_reader :all_from_domain
    attr_reader :covered_from_domain
  
    # @param [Fixnum] threeshold Under this threeshold, a file is considered as uncovered.
    # @param [Hash] raw_results Must be the result from Coverage.result
    #   You can set the threeshold above 100% (to be sure to see all files) but you
    #   cannot set it under 0.
    def initialize threeshold, raw_results
      raise ArgumentError if threeshold < 0
      @threeshold = threeshold
      @result = raw_results
      exclude_external_sources
      exclude_sources_above_threeshold
    end
    
    private
    
    def exclude_external_sources
      here = Dir.pwd
      @all_from_domain = @result.select {|key, value| key.start_with? here}
    end
    
    def exclude_sources_above_threeshold 
      @covered_from_domain = @all_from_domain.select {|key, value| 
        CoverageStat.coverage_percent(value) < @threeshold
      }
    end
    
  end
  
end
