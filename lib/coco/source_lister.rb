# -*- encoding: utf-8 -*-

module Coco

  # I retrieve the .rb files from a list of directories.
  class SourceLister
  
    # @param [String | Array<String>] folders Directories where to search the .rb files.
    def initialize folders
      unless folders.is_a? Array
        @folders = [folders]
      else
        @folders = folders
      end
      @folders.each {|folder| raise ArgumentError unless File.directory?(folder)}
      @list = []
    end
    
    # @return [Array<String>] A list of all .rb files from the directories given on instanciation.
    def list
      @folders.each do |folder|
        rb_files = File.join(folder, "**", "*.rb")
        @list += Dir.glob(rb_files)
      end
      @list.map {|file| File.expand_path(file)}
    end
    
  end

end
