require 'delegate'

module Coco

  # A very brief summary of the coverage result.
  #
  class Summary < SimpleDelegator

    def to_s
      "Cover #{average}% | #{uncovered_count} uncovered | #{count} files"
    end
  end
end
