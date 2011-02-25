# -*- encoding: utf-8 -*-

require 'erb'

module Coco
  
  # From me, you can obtain ERB templates.
  class Template
    # @param [String] filename An ERB template
    # @return [ERB]
    def self.open filename
      io = IO.readlines(filename, nil)
			return ERB.new(io[0], nil, '><')
    end
  end

end
