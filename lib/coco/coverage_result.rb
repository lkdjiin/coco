module Coco

  # Only keep the results of interest from the big results (from Coverage.result)
  class CoverageResult
  
    def initialize threeshold
      raise ArgumentError if threeshold < 0
      @threeshold = threeshold
      @result = nil
    end
    
    def result raw_coverage_result
      @result = raw_coverage_result
      exclude_external_sources
      exclude_sources_above_threeshold
      @result
    end
    
    private
    
    def exclude_external_sources
      here = Dir.pwd
      @result = @result.select {|key, value| key.start_with? here}
    end
    
    def exclude_sources_above_threeshold 
      @result = @result.select {|key, value| 
        CoverageStat.coverage_percent(value) < @threeshold
      }
    end
    
  end
  
end
