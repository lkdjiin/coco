# -*- encoding: utf-8 -*-

module Coco

  # Public: I populate the coverage/ directory with files, if any.
  class HtmlFilesWriter

    # Public: Initialize a new HtmlFilesWriter.
    #
    # html_files - Hash, key is filename, value is html content.
    def initialize(html_files)
      @html_files = html_files
      @html_dir = HtmlDirectory.new
    end

    # Public: Write HTML files in the right place.
    #
    # Returns nothing.
    def write
      @html_dir.clean
      if @html_files.size > 0
        @html_dir.setup
        write_each_file
      end
    end

    private

    def write_each_file
      @html_files.each do |filename, html|
        FileWriter.write File.join(
          @html_dir.coverage_dir, Helpers.rb2html(filename)), html
      end
    end
  end
end
