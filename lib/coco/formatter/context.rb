# -*- encoding: utf-8 -*-

module Coco
  
  # Contextual information for ERB template, representing each covered files.
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
  
  # Contextual information for ERB template, representing index.html.
  class IndexContext
  
    # @todo doc, inheritance (with Context)
		def initialize title, covered, uncovered
			@title = title
      @covered = covered
      @uncovered = uncovered
		end
		
		def get_binding
			binding
		end
	end

end
