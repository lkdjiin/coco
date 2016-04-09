module Coco

  # Assembles data required to represent a line on the index HTML
  # report.
  #
  module IndexLine

    # filename - The absolute String filename.
    # coverage - An Array of hit.
    #
    # Returns an Array.
    #
    def self.build(filename, coverage)
      [
        CoverageStat.coverage_percent(coverage),
        Helpers.name_for_html(filename),
        Helpers.rb2html(filename),
      ]
    end
  end
end
