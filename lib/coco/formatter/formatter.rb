# -*- encoding: utf-8 -*-

module Coco
  
  # My childs will format coverages information.
  # @abstract
  class Formatter
    # @param [Hash] raw_coverages The hash from Coverage.result
    def initialize raw_coverages
      @raw_coverages = raw_coverages
    end
    
    def format
      "Implement me in child"
    end
  end

end
