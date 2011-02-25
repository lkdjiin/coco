# -*- encoding: utf-8 -*-

module Coco

  module Helpers
  
    def Helpers.rb2html name
      name.sub(Dir.pwd, '').tr('/\\', '_') + '.html'
    end
    
    def Helpers.index_title
      "COde COverage #{File.read(File.join($COCO_PATH, 'VERSION')).strip} for #{File.basename(Dir.pwd)}"
    end
    
    # @param [Array<String>] files List of filenames
    def Helpers.expand files
      files.map {|file| File.expand_path file}
    end
    
  end
  
end
