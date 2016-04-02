module Coco

  # Contextual information for ERB template, representing index.html.
  #
  class IndexContext

    # Public: Initialize an IndexContext for the index file in the HTML
    # report.
    #
    # title     - The String title for the report.
    # covered   - Array of subarrays. Each subarray is:
    #             [
    #               Fixnum coverage percentage,
    #               String formatted filename (HTML ready),
    #               String real filename
    #             ]
    #             FIXME Need a class to handle subarrays.
    # uncovered - Array of String filenames. The filenames are already
    #             formatted, ready to be display in an HTML file.
    # summary   - A Summary object.
    #
    def initialize(title, covered, uncovered, summary)
      @title = title
      @covered = covered
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
