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
    end
    
  end
  
end
