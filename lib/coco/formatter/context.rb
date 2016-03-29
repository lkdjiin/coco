module Coco

  # Contextual information for ERB template, representing each covered files.
  #
  class Context

    # Public: Initialize a Context for a covered file shown in the HTML
    # report.
    #
    # filename - A String name of the source file.
    # lines    - An Array of lines.
    #
    def initialize(filename, lines)
      @filename = filename
      @lines = lines
    end
		
    # Public: Get the object's binding.
    #
    # Returns Binding.
    #
    def get_binding
      binding
    end
  end

end
