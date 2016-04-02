module Coco

  # My childs will format coverages information.
  # Kind of abstract class, my childs must implements the `format`
  # method.
  class Formatter

    # raw_coverages - The Hash from Coverage.result. Keys are filenames
    #                 and values are an Array representing each lines of
    #                 the file :
    #                 + nil       : Unreacheable (comments, etc).
    #                 + 0         : Not hit.
    #                 + 1 or more : Number of hits.
    # uncovered     - An Array list of uncovered files.
    #
    # TODO I think covered is a better name than raw_coverages
    def initialize(raw_coverages, uncovered)
      @raw_coverages = raw_coverages
      @uncovered = uncovered
    end
  end
end
