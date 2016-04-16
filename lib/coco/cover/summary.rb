module Coco

  # A very brief summary of the coverage result.
  #
  class Summary
    attr_reader :count, :uncovered_count

    def initialize(result, uncovered)
      @uncovered_count = uncovered.size
      @coverable_files = result.coverable_files
      @count = @coverable_files.size + @uncovered_count
    end

    def to_s
      "Cover #{average}% | #{uncovered_count} uncovered | #{count} files"
    end

    # Public: Computes the average coverage rate.
    # The formula is simple:
    #
    # N = number of files
    # f = a file
    # average = sum(f_i%) / N
    #
    # In words: Take the sum of the coverage's percentage of all files
    # and divide this sum by the number of files.
    #
    # Returns the Fixnum rounded average rate of coverage.
    #
    def average
      files_present? ? (sum / count).round : 0
    end

    private

    attr_reader :coverable_files

    # Returns the Float sum of all files' percentage.
    #
    def sum
      coverable_files.values.map do |hits|
        CoverageStat.real_percent(hits)
      end.reduce(&:+)
    end

    def files_present?
      count > 0
    end
  end
end
