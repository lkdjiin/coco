# -*- encoding: utf-8 -*-

module Coco

  # Public: Collection of application's helpers methods.
  #
  # TODO The app is full of `Dir.pwd`. This is the root project directory
  #   and must be in Configuration class (or Coco module ?).
  module Helpers

    # Public: Get html filename (from a ruby filename) suitable for the
    # coverage directory.
    #
    # name - String full path filename.
    #
    # Examples
    #
    #   ruby = '/home/user/my_project/lib/source.rb'
    #   html = Helpers.rb2html(ruby)
    #   #=> '_lib_source.rb.html'
    #
    # Returns String HTML filename.
    def Helpers.rb2html name
      name.sub(Dir.pwd, '').tr('/\\', '_') + '.html'
    end

    # Public: Get page title for the index.html file.
    #
    # Returns String.
    def Helpers.index_title
      project_name = File.basename(Dir.pwd)
      version = File.read(File.join($COCO_PATH, 'VERSION')).strip
      "#{project_name} - Code coverage (coco #{version})"
    end

    # Public: Expands a bulk of filenames into full path filenames.
    #
    # files - List of filenames as an Array of String.
    #
    # Returns an Array of String.
    def Helpers.expand files
      files.map {|file| File.expand_path file}
    end

    # Public: Get all ruby files from a directory, including
    # sub-directories.
    #
    # directory - String directory to look into.
    #
    # Returns an Array of String.
    def Helpers.rb_files_from directory
      rb_files = File.join(directory, "**", "*.rb")
      Dir.glob(rb_files)
    end

  end

end
