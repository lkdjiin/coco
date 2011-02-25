# -*- encoding: utf-8 -*-

module Coco
  
  # I write the html index.
  class HtmlIndexWriter
    def initialize index
      @index = index
      @dir = HtmlDirectory.new.coverage_dir
    end
    
    def write
      if File.exist?(@dir)
        FileWriter.write File.join(@dir, 'index.html'), @index
      end
    end
  end
  
end
