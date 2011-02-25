# -*- encoding: utf-8 -*-

module Coco

  # I retrieve the .rb files from a list of directories.
  class SourceLister
  
    # @param [Hash] config
    def initialize config
      @exclude_files = config[:excludes]
      dirs = config[:directories]
      unless dirs.is_a? Array
        @folders = [dirs]
      else
        @folders = dirs
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
      @list.map! {|file| File.expand_path(file)}
      unless  @exclude_files.nil?
        @exclude_files.each do |filename|
          @list.delete File.expand_path(filename)
        end
      end
      @list
    end
    
  end

end
