# -*- encoding: utf-8 -*-

module Coco

  # Give statistics about an array of lines hit.
  #
  # An "array of lines hit" is an array of integers, possibly nil.
  # Each integer represents the state of a source line:
  # * nil: source line will never be reached (like comments)
  # * 0: source line could be reached, but was not
  # * 1 and above: number of time the source line has been reached
  class CoverageStat
    
    def CoverageStat.remove_nil_from hits
      hits.select {|elem| not elem.nil?}
    end
    
    def CoverageStat.number_of_covered_lines hits
      hits.select {|elem| elem > 0}.size
    end
    
    def CoverageStat.coverage_percent hits
      hits = CoverageStat.remove_nil_from hits
      return 0 if hits.empty?
      one_percent = 100.0 / hits.size
      (CoverageStat.number_of_covered_lines(hits) * one_percent).to_i
    end
    
  end
  
end
