# -*- encoding: utf-8 -*-

module Coco
  
  # Contextual information for ERB template.
  class Context
  
    # @param [String] filename Name of the source file
    # @param [Array] lines 
		def initialize filename, lines
			@filename = filename
      @lines = lines
		end
		
		def get_binding
			binding
		end
	end

end
