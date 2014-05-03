# -*- encoding: utf-8 -*-

module Coco

  # I prepare the coverage/ directory for html files.
  class HtmlDirectory
    attr_reader :coverage_dir
    
    def initialize
      @coverage_dir = 'coverage'
      @css_dir = 'coverage/css'
      @img_dir = 'coverage/img'
      css = File.join($COCO_PATH, 'template/css')
      @css_files = Dir.glob(css + '/*')
      img = File.join($COCO_PATH, 'template/img')
      @img_files = Dir.glob(img + '/*')
    end
    
    # Delete the coverage/ directory
    def clean
      FileUtils.remove_dir @coverage_dir if File.exist? @coverage_dir
    end
    
    def setup
      FileUtils.makedirs @css_dir
      FileUtils.makedirs @img_dir
      FileUtils.cp @css_files, @css_dir
      FileUtils.cp @img_files, @img_dir
    end
    
    # I list the html files from the coverage directory
    def list
      files = Dir.glob("#{@coverage_dir}/*.html")
      files.map {|file| File.basename(file) }
    end
    
  end

end
