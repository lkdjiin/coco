module Coco

  # I retrieve the list of uncovered (0%) .rb files.
  #
  class UncoveredLister

    # sources - Array of String list of filenames.
    # covered - Hash raw coverage from the domain.
    #
    def initialize(sources, covered)
      @source_files = Helpers.expand(sources)
      @covered_files = Helpers.expand(covered.keys)
    end

    # Returns Array of String list of uncovered filenames.
    #
    def list
      list = []
      @source_files.each do |elem|
        list << elem unless @covered_files.include?(elem)
      end
      list
    end
  end
end
