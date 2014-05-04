# -*- encoding: utf-8 -*-

module Coco

  # I prepare the coverage/ directory for html files.
  class HtmlDirectory
    COVERAGE_DIR = 'coverage'

    def initialize
      css = File.join($COCO_PATH, 'template/css')
      @css_files = Dir.glob(css + '/*')
      img = File.join($COCO_PATH, 'template/img')
      @img_files = Dir.glob(img + '/*')
    end

    def coverage_dir
      COVERAGE_DIR
    end

    # Delete the coverage/ directory
    def clean
      FileUtils.remove_dir(coverage_dir) if File.exist?(coverage_dir)
    end

    def setup
      FileUtils.makedirs(css_dir)
      FileUtils.makedirs(image_dir)
      FileUtils.cp(@css_files, css_dir)
      FileUtils.cp(@img_files, image_dir)
    end

    # I list the html files from the coverage directory
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
