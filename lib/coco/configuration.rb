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
  #
  class Configuration < Hash

    DEFAULT_OPTIONS = {
      threshold: 100,
      include: ['lib'],
      exclude: %w( spec test ),
      single_line_report: true,
      always_run: true,
      show_link_in_terminal: false,
      exclude_above_threshold: true,
      theme: 'light',
    }.freeze

    # Public: Initialize a Configuration.
    #
    def initialize
      merge!(DEFAULT_OPTIONS)
      if File.exist?('.coco.yml')
        merge!(YAML.load_file('.coco.yml'))
      # Deprecated: Support of '.coco' file will be removed in v1.0.
      elsif File.exist?('.coco')
        warn(DeprecatedMessage.for_legacy_config_file)
        merge!(YAML.load_file('.coco'))
      end

      ensure_known_theme
      ensure_threeshold_compatibility
      ensure_directories_compatibility
      ensure_excludes_compatibility
      expand_directories
      remove_directories
    end

    # Public: Code coverage not have to run with every test/spec runs.
    #
    # Here are the rules:
    # If the configuration key :always_run is set to true, we always
    # run the coverage.
    # In case the configuration key :always_run is set to false, we have
    # to check for an environment variable named 'COCO' to decide if
    # we launch the coverage or not. When 'COCO' doesn't exist, or is
    # the empty string, or '0', or 'false', we don't run coverage.
    # When 'COCO' is set to any other value, we start coverage.
    #
    # Returns true if coverage should start.
    def run_this_time?
      if self[:always_run]
        true
      else
        ![nil, '', '0', 'false'].include?(ENV['COCO'])
      end
    end

    private

    def expand_directories
      self[:exclude].each do |file_or_dir|
        add_files file_or_dir if File.directory?(file_or_dir)
      end
    end

    def add_files(dir)
      Helpers.rb_files_from(dir).each { |file| self[:exclude] << file }
    end

    def remove_directories
      self[:exclude].delete_if { |file_or_dir| File.directory?(file_or_dir) }
    end

    def ensure_threeshold_compatibility
      if threeshold_present?
        warn(DeprecatedMessage.for_threeshold)
        self[:threshold] = self[:threeshold]
      end
    end

    def threeshold_present?
      self[:threeshold]
    end

    def ensure_directories_compatibility
      if directories_present?
        warn(DeprecatedMessage.for_directories)
        self[:include] = self[:directories]
      end
    end

    def directories_present?
      self[:directories]
    end

    def ensure_excludes_compatibility
      if excludes_present?
        warn(DeprecatedMessage.for_excludes)
        self[:exclude] = self[:excludes]
      end
    end

    def excludes_present?
      self[:excludes]
    end

    def ensure_known_theme
      unless %w( light dark ).include?(self[:theme])
        warn("\n\nThe theme '#{self[:theme]}' didn't exist.\n\n")
        self[:theme] = 'light'
      end
    end
  end
end
