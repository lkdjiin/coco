module Coco

  # Public: I prepare the coverage/ directory for html files.
  #
  class HtmlDirectory

    # Public: Initialize a new HtmlDirectory object.
    #
    # config - A Coco::Configuration object.
    #
    def initialize(config)
      @config = config
      @theme = Theme.new(@config[:theme])
      img = File.join(Coco::ROOT, 'template/img')
      @img_files = Dir.glob(img + '/*')
    end

    # Public: Get the name of the directory where the HTML report is
    # stored.
    #
    # Returns String.
    def coverage_dir
      @coverage_dir ||= @config[:output_directory]
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
      "#{coverage_dir}/css"
    end

    def image_dir
      "#{coverage_dir}/img"
    end

    def js_dir
      "#{coverage_dir}/js"
    end
  end
end
