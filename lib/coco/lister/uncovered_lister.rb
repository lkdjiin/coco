# -*- encoding: utf-8 -*-

module Coco

  # I retrieve the list of uncovered .rb files
  class UncoveredLister
    
    # @param [Array<String>] sources List of filenames
    # @param [Hash] covered Raw coverage from the domain
    def initialize sources, covered
      @source_files = sources
      @covered_files = covered.keys
    end
    
    def list
      list = []
      @source_files.each do |elem|
        list << elem unless @covered_files.include?(elem)
      end
      list
    end
    
  end
  
end
