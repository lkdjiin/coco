require './spec/helper'

describe ConsoleFormatter do

  it "should respond to format" do
    formatter = ConsoleFormatter.new(COVERAGE_90, ['a', 'b', 'c'], 100)
    formatter.respond_to?(:format).should == true
  end

  it "should return percents and filename" do
    formatter = ConsoleFormatter.new(COVERAGE_80, [], 100)
    result = formatter.format
    result.should == "\e[33m80% the/filename/80\e[0m"
  end

  it "should return percents and filename and uncovered" do
    formatter = ConsoleFormatter.new(COVERAGE_80, ['a'], 100)
    result = formatter.format
    result.should == "\e[31m0% a\e[0m\n" +
                     "\e[33m80% the/filename/80\e[0m"
  end

  it "should sort by percentage" do
    formatter = ConsoleFormatter.new(COVERAGE_100_90_80, [], 100)
    result = formatter.format
    result.should == "\e[33m80% the/filename/80\e[0m\n" +
                     "\e[33m90% the/filename/90\e[0m\n" +
                     "\e[32m100% the/filename/100\e[0m"
  end

  it "should sort by percentage uncovered too" do
    formatter = ConsoleFormatter.new(COVERAGE_100_90_80, ['a', 'b'], 100)
    result = formatter.format
    result.should == "\e[31m0% a\e[0m\n" +
                     "\e[31m0% b\e[0m\n" +
                     "\e[33m80% the/filename/80\e[0m\n" +
                     "\e[33m90% the/filename/90\e[0m\n" +
                     "\e[32m100% the/filename/100\e[0m"
  end

  it "should put in green when >= threshold" do
    formatter = ConsoleFormatter.new(COVERAGE_100_90_80, ['a', 'b'], 90)
    result = formatter.format
    result.should == "\e[31m0% a\e[0m\n" +
                     "\e[31m0% b\e[0m\n" +
                     "\e[33m80% the/filename/80\e[0m\n" +
                     "\e[32m90% the/filename/90\e[0m\n" +
                     "\e[32m100% the/filename/100\e[0m"
  end

  context "when 'single_line_report' is true" do

    context "and there is some uncovered files" do
      it "should return a message" do
        formatter = ConsoleFormatter.new(COVERAGE_90, ['a', 'b', 'c'], 100)
        result = formatter.format true
        result.should == "\e[33mSome files are uncovered\e[0m"
      end
    end

    context "and there is no uncovered files" do
      it "should return nothing" do
        formatter = ConsoleFormatter.new(COVERAGE_90, [], 100)
        result = formatter.format true
        result.should == ""
      end
    end

  end

end
