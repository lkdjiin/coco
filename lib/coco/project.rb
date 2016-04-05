module Coco

  class Project

    # raw_result - The hash obtain by the call to `Coverage.result`.
    # out        - The output where results will be displayed, by
    #              default this is stdout.
    #
    def self.run(raw_result, out = STDOUT)
      new(raw_result, out).run
    end

    def initialize(raw_result, out)
      @raw_result = raw_result
      @out = out
      @config = Configuration.new
    end

    def run
      return unless @config.run_anytime?

      report_on_console
      report_in_html
    end

    private

    def report_on_console
      formatter = ConsoleFormatter.new(uncovered, @config[:threshold],
                                       result, @config)
      @out.puts formatter.format
      @out.puts formatter.link if @config[:show_link_in_terminal]
    end

    def report_in_html
      report_code_files
      report_index
    end

    def report_code_files
      files = HtmlFormatter.new(result.coverable_files).format
      HtmlFilesWriter.new(files, @config[:theme]).write
    end

    def report_index
      index = HtmlIndexFormatter.new(uncovered, result,
                                     @config[:threshold]).format
      HtmlIndexWriter.new(index).write
    end

    def result
      @result ||= CoverageResult.new(@config, @raw_result)
    end

    def uncovered
      @uncovered ||= UncoveredLister.new(sources, result.coverable_files).list
    end

    def sources
      SourceLister.new(@config).list
    end
  end
end
