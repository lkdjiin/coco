# -*- encoding: utf-8 -*-

module Coco

  # Extend String with ANSI colorization.
  class ColoredString < String
    
    def initialize(str="")
      super(str)
    end
    
    def red
      colorize "\033[31m"
    end
    
    def yellow
      colorize "\033[33m"
    end
    
    private
    
    def colorize color_code
      if RUBY_PLATFORM =~ /win32/
        self
      else
        "#{color_code}#{self}\033[0m"
      end
    end
  end
  
end
