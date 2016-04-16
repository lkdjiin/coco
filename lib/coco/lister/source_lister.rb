module Coco

  # I retrieve the .rb files from a list of directories.
  class SourceLister

    # config - Hash.
    def initialize(config)
      @exclude_files = config[:exclude]
      dirs = config[:include]
      @folders = [*dirs]
      @folders.each do |folder|
        unless File.directory?(folder)
          raise ArgumentError, "Not a folder: #{folder}"
        end
      end
      @list = []
    end

    # Returns Array of String, that is a list of all `.rb` files from
    # the directories found in configuration.
    def list
      look_for_sources
      @list.map! { |file| File.expand_path(file) }
      exclude_files_user_dont_want if @exclude_files
      @list
    end

    private

    def look_for_sources
      @folders.each do |folder|
        @list += Helpers.rb_files_from folder
      end
    end

    def exclude_files_user_dont_want
      @exclude_files.each do |filename|
        exclude_path(File.expand_path(filename))
      end
    end

    def exclude_path(full_path)
      if File.file?(full_path)
        @list.delete full_path
      elsif File.directory?(full_path)
        exclude_all_from_dir full_path
      end
    end

    def exclude_all_from_dir(full_path)
      Helpers.rb_files_from(full_path).each do |file|
        @list.delete File.expand_path(file)
      end
    end
  end
end
