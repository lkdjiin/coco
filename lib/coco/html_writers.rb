require 'coco/filename'

module Coco

  # I prepare the directory for html files.
  class HtmlDirectory
    attr_reader :coverage_dir
    
    def initialize
      @coverage_dir = 'coverage'
      @css = File.join($COCO_PATH, 'template/coco.css')
    end
    
    def clean
      FileUtils.remove_dir @coverage_dir if File.exist? @coverage_dir
    end
    
    def setup
      FileUtils.makedirs @coverage_dir
      FileUtils.copy @css, @coverage_dir
    end
    
    # I list the html files from the coverage directory
    def list
      files = Dir.glob("#{@coverage_dir}/*.html")
      files.map {|file| File.basename(file)}
    end
  end
  
  # I populate the html directory with files if any.
  class HtmlFilesWriter
    include Filename
  
    # @param [Hash] html_files Key is filename, value is html content
    def initialize html_files
      @html_files = html_files
      @html_dir = HtmlDirectory.new
    end
    
    def write
      @html_dir.clean
      if @html_files.size > 0
        @html_dir.setup
        write_each_file
      end
    end
    
    private
    
    def write_each_file
      @html_files.each do |filename, html|
        FileWriter.write File.join('coverage', rb2html(filename)), html
      end
    end
    
  end
  
  # I write one file.
  class FileWriter
    def FileWriter.write filename, content
      file = File.new(filename, "w")
      file.write content
      file.close
    end
  end
  
  # I write the html index.
  class HtmlIndexWriter
    def initialize index
      @index = index
    end
    
    def write
      FileWriter.write File.join(HtmlDirectory.new.coverage_dir, 'index.html'), @index
    end
  end
  
end
