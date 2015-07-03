module Coco

  # I format coverages data for console output.
  class ConsoleFormatter < Formatter

    # Public: Get a colored report, formatted for console output.
    #
    # single_line_report - Boolean
    #
    # Returns percent covered and associated filenames as a multilines
    # String
    def format(single_line_report = false)
      single_line_report ? single_line_message : @formatted_output.join("\n")
    end

    # Get the link for the report's index file.
    #
    # Returns String.
    def link
      unless @formatted_output.empty?
        "See file://" +
          File.expand_path(File.join(Coco::HtmlDirectory.new.coverage_dir,
                                     'index.html'))
      end
    end

    # Public: Creates a new ConsoleFormatter.
    #
    # covered   - See base class Formatter.
    # uncovered - See base class Formatter.
    # threshold - The Fixnum percentage threshold.
    def initialize(covered, uncovered, threshold)
      super(covered, uncovered)
      @formatted_output = []
      compute_percentage
      add_percentage_to_uncovered
      @formatted_output.sort!
      @formatted_output.map! do |percentage, filename|
        text = ColoredString.new "#{percentage}% #{filename}"
        if percentage <= 50
          text.red
        elsif percentage >= threshold
          text.green
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
      @uncovered.each {|filename| @formatted_output << [0, filename] }
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
