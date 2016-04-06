module Coco

  # Group all messages for deprecated things in this module.
  #
  module DeprecatedMessage

    def self.for_excludes
      "Please change `excludes` to `exclude`.\n" \
      'Support for `excludes` configuration key will ' \
      'be removed in future Coco versions.'
    end

    def self.for_directories
      "Please change `directories` to `include`.\n" \
      'Support for `directories` configuration key will ' \
      'be removed in future Coco versions.'
    end

    def self.for_threeshold
      "Please change `threeshold` to `threshold`.\n" \
      'Support for the misspelt `threeshold` configuration key will ' \
      'be removed in future Coco versions.'
    end

    def self.for_legacy_config_file
      "Please use `.coco.yml` instead of `.coco`.\n" \
      'Support for `.coco` will be removed in future versions.'
    end

  end
end
