# -*- encoding: utf-8 -*-

require 'yaml'

module Coco

  # I know the configuration of coco.
  #
  # @example read the threeshold value
  #   config = Configuration.new
  #   config[:threeshold]
  #   => 90
  #
  # You can override the default configuration by putting a '.coco' file 
  # in YAML format in the project root directory.
  # @example to override the threeshold put this line in a '.coco' file:
  #   :threeshold: 70
  #
  # @note You can set the threeshold above 100% (to be sure to see all files) but you
  #   cannot set it under 0.
  class Configuration < Hash
  
    def initialize
      self[:threeshold] = 90
      self[:directories] = ['lib']
      self[:excludes] = []
      if File.exist?('.coco')
        conf = YAML.load_file '.coco'
        self.merge!(conf)
      end
      expand_directories
      remove_directories
    end
    
    private
    
    def expand_directories
      self[:excludes].each do |file_or_dir|
        add_files file_or_dir if File.directory?(file_or_dir)
      end
    end
    
    def add_files dir
      Helpers.rb_files_from(dir).each {|file| self[:excludes] << file }
    end
    
    def remove_directories
      self[:excludes].delete_if {|file_or_dir| File.directory?(file_or_dir)}
    end
    
  end
  
end
