require './spec/helper'

describe ConsoleFormatter do

  let(:cr) {
    instance_double(CoverageResult, count: 123, uncovered_count: 17,
                             average: 60)
  }

  let(:config_single) { {single_line_report: true} }
  let(:config_multi) { {single_line_report: false} }

  describe 'API' do
    before do
      @subject = ConsoleFormatter.new(COVERAGE_90, ['a', 'b', 'c'], 100, cr,
                                     config_single)
    end

    specify { expect(@subject).to respond_to :format }
    specify { expect(@subject).to respond_to :link }
  end

  it "returns percents and filename" do
    formatter = ConsoleFormatter.new(COVERAGE_80, [], 100, cr, config_multi)
    expect(formatter.format).to include("\e[33m80% the/filename/80\e[0m")
  end

  it "returns percents and filename and uncovered" do
    formatter = ConsoleFormatter.new(COVERAGE_80, ['a'], 100, cr, config_multi)

    expect(formatter.format).to include("\e[31m0% a\e[0m\n" +
                                        "\e[33m80% the/filename/80\e[0m")
  end

  it "sorts by percentage" do
    formatter = ConsoleFormatter.new(COVERAGE_100_90_80, [], 100, cr,
                                     config_multi)
    result = formatter.format

    expect(result).to include("\e[33m80% the/filename/80\e[0m\n" +
                              "\e[33m90% the/filename/90\e[0m\n" +
                              "\e[32m100% the/filename/100\e[0m")
  end

  it "sorts by percentage uncovered" do
    formatter = ConsoleFormatter.new(COVERAGE_100_90_80, ['a', 'b'], 100, cr,
                                    config_multi)
    result = formatter.format

    expect(result).to include("\e[31m0% a\e[0m\n" +
                              "\e[31m0% b\e[0m\n" +
                              "\e[33m80% the/filename/80\e[0m\n" +
                              "\e[33m90% the/filename/90\e[0m\n" +
                              "\e[32m100% the/filename/100\e[0m")
  end

  it "puts in green when >= threshold" do
    formatter = ConsoleFormatter.new(COVERAGE_100_90_80, ['a', 'b'], 90, cr,
                                    config_multi)
    result = formatter.format

    expect(result).to include("\e[31m0% a\e[0m\n" +
                              "\e[31m0% b\e[0m\n" +
                              "\e[33m80% the/filename/80\e[0m\n" +
                              "\e[32m90% the/filename/90\e[0m\n" +
                              "\e[32m100% the/filename/100\e[0m")
  end

  context "when it is a single line report" do

    context "with some uncovered files" do
      it "returns the summary" do
        formatter = ConsoleFormatter.new(COVERAGE_90, ['a', 'b', 'c'], 100,
                                         cr, config_single)
        result = formatter.format

        expect(result).to eq("\e[33mCover 60% | 17 uncovered | 123 files\e[0m")
      end
    end

    context "with no uncovered files" do
      it "returns the summary" do
        formatter = ConsoleFormatter.new(COVERAGE_90, [], 100, cr,
                                        config_single)
        result = formatter.format

        expect(result).to include("Cover", "uncovered", "files")
      end
    end

  end

  describe 'index file link' do
    it "returns a local link to index" do
      formatter = ConsoleFormatter.new(COVERAGE_90, [], 100, cr,
                                      config_multi)
      link = formatter.link

      expect(link).to include 'See file:///', 'coverage/index.html'
    end
  end

end
