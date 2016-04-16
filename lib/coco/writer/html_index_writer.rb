module Coco

  # Public: I write the index.html
  #
  class HtmlIndexWriter

    # Public: Initialize a new HtmlIndexWriter object.
    #
    # index - A String HTML document.
    #
    def initialize(index)
      @index = index
      @dir = HtmlDirectory.new.coverage_dir
    end

    # Public: Write the index file in the right place.
    #
    # Returns nothing.
    #
    def write
      if File.exist?(@dir)
        FileWriter.write File.join(@dir, 'index.html'), @index
      end
    end
  end
end
