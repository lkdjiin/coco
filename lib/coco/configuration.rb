# -*- encoding: utf-8 -*-

require 'yaml'

module Coco

  # Public: I know the configuration of coco.
  # You can override the default configuration by putting a '.coco.yml'
  # file in YAML format in the project root directory.
  #
  # Examples
  #
  #   # Read the threshold value
  #   config = Configuration.new
  #   config[:threshold]
  #   # => 100
  #
  #   # To override the threshold, put this line in '.coco.yml' file:
  #   # :threshold: 70
  #
  # Note you can set the threshold above 100% (to be sure to see all
  # files) but you cannot set it under 0.
  class Configuration < Hash

    # Public: Initialize a Configuration.
    def initialize
      self[:threshold] = 100
      self[:directories] = ['lib']
      self[:excludes] = []
      self[:single_line_report] = false
      self[:always_run] = true
      self[:show_link_in_terminal] = false
      if File.exist?('.coco.yml')
        self.merge!(YAML.load_file('.coco.yml'))
      # Deprecated: Support of '.coco' file will be removed in v1.0.
      elsif File.exist?('.coco')
        self.merge!(YAML.load_file('.coco'))
      end

      ensure_threeshold_compatibility
      expand_directories
      remove_directories
    end

    # Public: Code coverage not have to run with every test/spec runs.
    #
    # Here are the rules:
    # If the configuration key :always_run is set to true, we always
    # run the coverage.
    # In case the configuration key :always_run is set to false, we have
    # to check for an environement variable named 'COCO' to decide if
    # we launch the coverage or not. When 'COCO' doesn't exist, or is
    # the empty string, or '0', or 'false', we don't run coverage.
    # When 'COCO' is set to any other value, we start coverage.
    #
    # Returns true if coverage should start.
    def user_wants_to_run?
      if self[:always_run]
        true
      else
        ![nil, '', '0', 'false'].include?(ENV['COCO'])
      end
    end

    private

    def expand_directories
      self[:excludes].each do |file_or_dir|
        add_files file_or_dir if File.directory?(file_or_dir)
      end
    end

    def add_files(dir)
      Helpers.rb_files_from(dir).each {|file| self[:excludes] << file }
    end

    def remove_directories
      self[:excludes].delete_if {|file_or_dir| File.directory?(file_or_dir) }
    end

    def ensure_threeshold_compatibility
      self[:threshold] = self[:threeshold] unless self[:threeshold].nil?
    end

  end

end
