require './spec/helper'

describe ConsoleFormatter do

  describe 'API' do
    let(:formatter) { ConsoleFormatter.new(COVERAGE_90, ['a', 'b', 'c'], 100) }
    specify { expect(formatter).to respond_to :format }
    specify { expect(formatter).to respond_to :link }
  end

  it "returns percents and filename" do
    formatter = ConsoleFormatter.new(COVERAGE_80, [], 100)
    result = formatter.format

    expect(result).to eq("\e[33m80% the/filename/80\e[0m")
  end

  it "returns percents and filename and uncovered" do
    formatter = ConsoleFormatter.new(COVERAGE_80, ['a'], 100)
    result = formatter.format

    expect(result).to eq("\e[31m0% a\e[0m\n" +
                         "\e[33m80% the/filename/80\e[0m")
  end

  it "sorts by percentage" do
    formatter = ConsoleFormatter.new(COVERAGE_100_90_80, [], 100)
    result = formatter.format

    expect(result).to eq("\e[33m80% the/filename/80\e[0m\n" +
                         "\e[33m90% the/filename/90\e[0m\n" +
                         "\e[32m100% the/filename/100\e[0m")
  end

  it "sorts by percentage uncovered" do
    formatter = ConsoleFormatter.new(COVERAGE_100_90_80, ['a', 'b'], 100)
    result = formatter.format

    expect(result).to eq("\e[31m0% a\e[0m\n" +
                         "\e[31m0% b\e[0m\n" +
                         "\e[33m80% the/filename/80\e[0m\n" +
                         "\e[33m90% the/filename/90\e[0m\n" +
                         "\e[32m100% the/filename/100\e[0m")
  end

  it "puts in green when >= threshold" do
    formatter = ConsoleFormatter.new(COVERAGE_100_90_80, ['a', 'b'], 90)
    result = formatter.format

    expect(result).to eq("\e[31m0% a\e[0m\n" +
                         "\e[31m0% b\e[0m\n" +
                         "\e[33m80% the/filename/80\e[0m\n" +
                         "\e[32m90% the/filename/90\e[0m\n" +
                         "\e[32m100% the/filename/100\e[0m")
  end

  context "when it is a single line report" do

    context "with some uncovered files" do
      it "returns a message" do
        formatter = ConsoleFormatter.new(COVERAGE_90, ['a', 'b', 'c'], 100)
        result = formatter.format true

        expect(result).to eq("\e[33mSome files are uncovered\e[0m")
      end
    end

    context "with no uncovered files" do
      it "returns nothing" do
        formatter = ConsoleFormatter.new(COVERAGE_90, [], 100)
        result = formatter.format true

        expect(result).to eq("")
      end
    end

  end

  describe 'index file link' do
    it "eeee" do
      formatter = ConsoleFormatter.new(COVERAGE_90, [], 100)
      link = formatter.link

      expect(link).to include 'See file:///', 'coverage/index.html'
    end
  end

end
