module Coco

  # Public: Collection of application's helpers methods.
  #
  module Helpers

    # Public: Get a String (ruby) source filename ready to be
    # displayed in the index file.
    #
    # name - String full path filename (normaly full path but, who
    #        knows? may be relative path).
    #
    # Examples
    #
    #   name = '/home/user/my_project/lib/source.rb'
    #   Helpers.name_for_html(name)
    #   #=> 'lib/<b>source.rb</b>'
    #
    # Returns the formatted String.
    #
    def self.name_for_html(name)
      name = File.expand_path(name)
      name = name.sub(Dir.pwd, '')
      name = name.sub(%r{^/}, '')
      base = File.basename(name)
      name.sub(base, "<b>#{base}</b>")
    end

    # Public: Get html filename (from a ruby filename) suitable for
    # the coverage directory.
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
    #
    def self.rb2html(name)
      name = name.sub(Dir.pwd, '')
      name = name.sub(%r{^/}, '')
      name = name.tr('/\\', '_')
      name + '.html'
    end

    # Public: Get page title for the index.html file.
    #
    # Returns String.
    #
    def self.index_title
      project_name = File.basename(Dir.pwd)
      version = File.read(File.join(Coco::ROOT, 'VERSION')).strip
      "#{project_name} - Code coverage (coco #{version})"
    end

    # Public: Expands a bulk of filenames into full path filenames.
    #
    # files - List of filenames as an Array of String.
    #
    # Returns an Array of String.
    #
    def self.expand(files)
      files.map { |file| File.expand_path(file) }
    end

    # Public: Get all ruby files from a directory, including
    # sub-directories.
    #
    # directory - String directory to look into.
    #
    # Returns an Array of String.
    #
    def self.rb_files_from(directory)
      rb_files = File.join(directory, '**', '*.rb')
      Dir.glob(rb_files)
    end

    # Public: Get the CSS class given a percentage. To use in the
    # index file.
    #
    # percentage - A Fixnum.
    #
    # Examples
    #
    #   Helpers.level_class(100)
    #   #=> 'green'
    #
    # Returns the String CSS class name.
    #
    def self.level_class(percentage)
      case percentage
      when 100 then 'green'
      when 80..99 then 'yellow'
      else
        'red'
      end
    end
  end
end
