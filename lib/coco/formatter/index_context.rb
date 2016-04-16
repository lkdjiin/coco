module Coco

  # Contextual information for ERB template, representing index.html.
  #
  class IndexContext

    # Public: Initialize an IndexContext for the index file in the HTML
    # report.
    #
    # title     - The String title for the report.
    # all       - Array of subarrays. Each subarray is:
    #             [
    #               Fixnum coverage percentage,
    #               String formatted filename (HTML ready),
    #               String real filename
    #             ]
    # uncovered - Array of String filenames. The filenames are already
    #             formatted, ready to be display in an HTML file.
    # summary   - A Summary object.
    # threshold - Fixnum.
    #
    def initialize(title, all, uncovered, summary, threshold)
      @title = title
      @covered, @greens = all.partition { |file| file.first < threshold }
      @uncovered = uncovered
      @summary = summary
    end

    # Public: Get the object's binding.
    #
    # Returns Binding.
    #
    def variables
      binding
    end
  end
end
