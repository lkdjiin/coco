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
  class Configuration < Hash
  
    def initialize
      self[:threeshold] = 90
      if File.exist?('.coco')
        conf = YAML.load_file '.coco'
        self.merge!(conf)
      end
    end
    
  end
  
end
