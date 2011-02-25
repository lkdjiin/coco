# -*- encoding: utf-8 -*-

module Coco
  
  # My childs will format coverages information.
  # @abstract
  class Formatter
    # @param [Hash] raw_coverages The hash from Coverage.result
    # @param [Array] uncovered List on uncovered files
    def initialize raw_coverages, uncovered
      @raw_coverages = raw_coverages
      @uncovered = uncovered
    end
    
    def format
      "Implement me in child"
    end
  end

end
