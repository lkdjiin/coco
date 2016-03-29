require 'delegate'

module Coco

  class Summary < SimpleDelegator

    def to_s
      "Cover #{average}% | #{uncovered_count} uncovered | #{count} files"
    end

  end
end
