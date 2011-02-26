# -*- encoding: utf-8 -*-

module Coco

  # Compute results of interest from the big results information (from Coverage.result)
  class CoverageResult
    # @return [Hash] Coverage for all the sources that live in the root project folder.
    attr_reader :all_from_domain
    # @return [Hash] Coverage for sources that are not sufficiently covered.
    #   More technically, the sources that live in the root project folder and for
    #   which the coverage percentage is under the threeshold. 
    attr_reader :covered_from_domain
  
    # @param [Hash] config
    # @param [Hash] raw_results Results obtained from Coverage.result
    def initialize config, raw_results
      @exclude_files = config[:excludes]
      @threeshold = config[:threeshold]
      raise ArgumentError if @threeshold < 0
      @result = raw_results
      exclude_external_sources
      exclude_files_user_dont_want
      exclude_sources_above_threeshold
    end
    
    private
    
    def exclude_external_sources
      here = Dir.pwd
      @all_from_domain = @result.select {|key, value| key.start_with? here}
    end
    
    def exclude_files_user_dont_want
      return if @exclude_files.nil?
      @exclude_files.each do |filename|
        @all_from_domain.delete(File.expand_path(filename))
      end
    end
    
    def exclude_sources_above_threeshold 
      @covered_from_domain = @all_from_domain.select {|key, value| 
        CoverageStat.coverage_percent(value) < @threeshold
      }
    end
    
  end
  
end
