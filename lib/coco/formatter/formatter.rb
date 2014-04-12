# -*- encoding: utf-8 -*-

module Coco
  
  # My childs will format coverages information.
  # Kind of abstract class.
  class Formatter
  
    # raw_coverages - The Hash from Coverage.result.
    # uncovered     - An Array list of uncovered files.
    # @todo I think covered is a better name than raw_coverages
    def initialize raw_coverages, uncovered
      @raw_coverages = raw_coverages
      @uncovered = uncovered
    end
    
    def format
      "Implement me in child"
    end
  end

end
