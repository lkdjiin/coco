module Coco

  # I format coverages information for console output.
  class ConsoleFormatter < Formatter

    # single_line_report - Boolean
    #
    # Returns percent covered and associated filenames as a String.
    def format(single_line_report = false)
      if single_line_report
        single_line_message
      else
        @formatted_output.join("\n")
      end
    end

    # Returns String.
    def link
      unless @formatted_output.empty?
        "See file://" +
          File.expand_path(File.join(Coco::HtmlDirectory.new.coverage_dir,
                                     'index.html'))
      end
    end

    # covered   - Hash
    # uncovered - Array
    def initialize(covered, uncovered)
      super(covered, uncovered)
      @formatted_output = []
      compute_percentage
      add_percentage_to_uncovered
      @formatted_output.sort!
      @formatted_output.map! do |percentage, filename|
        text = ColoredString.new "#{percentage}% #{filename}"
        if percentage <= 50
          text.red
        else
          text.yellow
        end
      end
    end

    private

    def compute_percentage
      @raw_coverages.each do |filename, coverage|
        percentage = CoverageStat.coverage_percent(coverage)
        @formatted_output << [percentage, filename]
      end
    end

    def add_percentage_to_uncovered
      @uncovered.each do |filename| @formatted_output << [0, filename] end
    end

    def single_line_message
      if @uncovered.empty?
        ""
      else
        ColoredString.new("Some files are uncovered").yellow
      end
    end

  end

end
