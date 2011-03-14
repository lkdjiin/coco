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
    
    # @return [Array<String>] A list of all .rb files from the directories found in configuration
    def list
      look_for_sources
      @list.map! {|file| File.expand_path(file)}
      exclude_files_user_dont_want
      @list
    end
    
    private
    
    def look_for_sources
      @folders.each {|folder| @list += Helpers.rb_files_from folder }
    end
    
    def exclude_files_user_dont_want
      return if @exclude_files.nil?
      
      @exclude_files.each do |filename|
        full_path = File.expand_path(filename)
        if File.file?(full_path)
          @list.delete full_path 
        elsif File.directory?(full_path)
          exclude_all_from_dir full_path
        end
      end
    end
    
    def exclude_all_from_dir full_path
      Helpers.rb_files_from(full_path).each do |file|
        @list.delete File.expand_path(file)
      end
    end
    
  end

end
