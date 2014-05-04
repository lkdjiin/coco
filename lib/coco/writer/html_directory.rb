# -*- encoding: utf-8 -*-

module Coco

  # Public: I prepare the coverage/ directory for html files.
  class HtmlDirectory
    COVERAGE_DIR = 'coverage'

    # Public: Initialize a new HtmlDirectory object.
    def initialize
      css = File.join($COCO_PATH, 'template/css')
      @css_files = Dir.glob(css + '/*')
      img = File.join($COCO_PATH, 'template/img')
      @img_files = Dir.glob(img + '/*')
    end

    # Public: Get the name of the directory where the HTML report is
    # stored.
    #
    # Returns String.
    def coverage_dir
      COVERAGE_DIR
    end

    # Public: Delete the directory where the HTML report is stored.
    #
    # Returns nothing.
    def clean
      FileUtils.remove_dir(coverage_dir) if File.exist?(coverage_dir)
    end

    # Public: Make all directories needed to store the HTML report, then
    # copy media files (css, images, etc.).
    #
    # Returns nothing.
    def setup
      FileUtils.makedirs(css_dir)
      FileUtils.makedirs(image_dir)
      FileUtils.cp(@css_files, css_dir)
      FileUtils.cp(@img_files, image_dir)
    end

    # Public: I list the html files from the directory where the HTML
    # report is stored.
    #
    # Returns nothing.
    def list
      files = Dir.glob("#{coverage_dir}/*.html")
      files.map {|file| File.basename(file) }
    end

    private

    def css_dir
      "#{COVERAGE_DIR}/css"
    end

    def image_dir
      "#{COVERAGE_DIR}/img"
    end
  end
end
