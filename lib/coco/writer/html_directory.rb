module Coco

  # Public: I prepare the coverage/ directory for html files.
  #
  class HtmlDirectory
    COVERAGE_DIR = 'coverage'.freeze

    # Public: Initialize a new HtmlDirectory object.
    #
    # theme - The String name of the theme. There is 2 builtin themes :
    #         light & dark. The default one is light.
    #
    def initialize(theme = 'light')
      @theme = Theme.new(theme)
      img = File.join(Coco::ROOT, 'template/img')
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
      FileUtils.makedirs([css_dir, image_dir, js_dir])
      FileUtils.cp(@theme.filename, File.join(css_dir, 'coco.css'))
      FileUtils.cp(@img_files, image_dir)
      FileUtils.cp(File.join(Coco::ROOT, 'template/js/coco.js'), js_dir)
    end

    # Public: I list the html files from the directory where the HTML
    # report is stored.
    #
    # Returns nothing.
    def list
      files = Dir.glob("#{coverage_dir}/*.html")
      files.map { |file| File.basename(file) }
    end

    private

    def css_dir
      "#{COVERAGE_DIR}/css"
    end

    def image_dir
      "#{COVERAGE_DIR}/img"
    end

    def js_dir
      "#{COVERAGE_DIR}/js"
    end
  end
end
