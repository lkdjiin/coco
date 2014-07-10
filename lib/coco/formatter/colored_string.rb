# -*- encoding: utf-8 -*-

module Coco

  # Public: Build String with ANSI colorization.
  # Do nothing on Windows.
  class ColoredString < String

    # Public: Initialize a new ColoredString object.
    #
    # str - A String.
    def initialize(str="")
      super(str)
    end

    # Public: Make a red string.
    #
    # Returns String ANSIfied in red.
    def red
      colorize "\033[31m"
    end

    # Public: Make a yellow string.
    #
    # Returns String ANSIfied in yellow.
    def yellow
      colorize "\033[33m"
    end

    def green
      colorize "\033[32m"
    end

    private

    def colorize(color_code)
      if RUBY_PLATFORM =~ /win32/
        self
      else
        "#{color_code}#{self}\033[0m"
      end
    end
  end
end
