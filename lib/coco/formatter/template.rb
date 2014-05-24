# -*- encoding: utf-8 -*-

require 'erb'

module Coco
  
  # From me, you can obtain ERB templates.
  class Template
    # filename - An String ERB template.
    #
    # Returns ERB.
    def self.open(filename)
      io = IO.readlines(filename, nil)
			ERB.new(io[0], nil, '><')
    end
  end

end
