# -*- encoding: utf-8 -*-

module Coco

  # @todo The app is full of <tt>Dir.pwd</tt>. This is the root project directory
  #   and must be in Configuration class (or Coco module ?).
  module Helpers
  
    # Get html filename (from a ruby filename) suitable for the coverage
    # directory.
    #
    # @example
    #   ruby = '/home/user/my_project/lib/source.rb'
    #   html = Helpers.rb2html(ruby)
    #   => '_lib_source.rb.html'
    #
    # @param [String] name Ruby filename
    # @return [String] Html filename
    def Helpers.rb2html name
      name.sub(Dir.pwd, '').tr('/\\', '_') + '.html'
    end
    
    # @return [String] The title of the index.html file
    def Helpers.index_title
      project_name = File.basename(Dir.pwd)
      version = File.read(File.join($COCO_PATH, 'VERSION')).strip
      "#{project_name} - Code coverage (coco #{version})"
    end
    
    # @param [Array<String>] files List of filenames
    # @return [Array<String>]
    def Helpers.expand files
      files.map {|file| File.expand_path file}
    end
    
    # @return [Array<String>] The list of ruby source files from +directory+. Recursive.
    def Helpers.rb_files_from directory
      rb_files = File.join(directory, "**", "*.rb")
      Dir.glob(rb_files)
    end
    
  end
  
end
