# -*- encoding: utf-8 -*-

module Coco
  
  # I write one file.
  class FileWriter
    def FileWriter.write(filename, content)
      file = File.new(filename, "w")
      file.write content
      file.close
    end
  end

end
