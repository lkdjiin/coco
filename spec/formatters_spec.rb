# -*- encoding: utf-8 -*-

require './spec/helper'

describe ConsoleFormatter do
  it "should respond to format" do
    formatter = ConsoleFormatter.new(COVERAGE_90, ['a', 'b', 'c'])
    formatter.respond_to?(:format).should == true
  end
  
  it "should return percents and filename" do
    formatter = ConsoleFormatter.new(COVERAGE_80, [])
    result = formatter.format
    result.should == "\e[33m80% the/filename/80\e[0m"
  end
  
  it "should return percents and filename and uncovered" do
    formatter = ConsoleFormatter.new(COVERAGE_80, ['a'])
    result = formatter.format
    result.should == "\e[31m0% a\e[0m\n" +
                     "\e[33m80% the/filename/80\e[0m"
  end
  
  it "should sort by percentage" do
    formatter = ConsoleFormatter.new(COVERAGE_100_90_80, [])
    result = formatter.format
    result.should == "\e[33m80% the/filename/80\e[0m\n" +
                     "\e[33m90% the/filename/90\e[0m\n" +
                     "\e[33m100% the/filename/100\e[0m"
  end
  
  it "should sort by percentage uncovered too" do
    formatter = ConsoleFormatter.new(COVERAGE_100_90_80, ['a', 'b'])
    result = formatter.format
    result.should == "\e[31m0% a\e[0m\n" +
                     "\e[31m0% b\e[0m\n" +
                     "\e[33m80% the/filename/80\e[0m\n" +
                     "\e[33m90% the/filename/90\e[0m\n" +
                     "\e[33m100% the/filename/100\e[0m"
  end
  
  context "when 'single_line_report' is true" do
    context "and there is some uncovered files" do
      it "should return a message" do
        formatter = ConsoleFormatter.new(COVERAGE_90, ['a', 'b', 'c'])
        result = formatter.format true
        result.should == "\e[33mSome files are uncovered\e[0m"
      end
    end
    context "and there is no uncovered files" do
      it "should return nothing" do
        formatter = ConsoleFormatter.new(COVERAGE_90, [])
        result = formatter.format true
        result.should == ""
      end
    end
  end
end

describe HtmlFormatter do

  it "should respond to format" do
    formatter = HtmlFormatter.new COVERAGE_70
    formatter.respond_to?(:format).should == true
  end
  
  it "should return the right number of html file(s)" do
    formatter = HtmlFormatter.new COVERAGE_30_70
    result = formatter.format
    result.size.should == 2
  end
  
  it "should return html file(s)" do
    formatter = HtmlFormatter.new COVERAGE_70
    result = formatter.format
    result.each {|k, v| v.start_with?('<!DOCTYPE html>').should == true }
  end
  
  # Bug 13
  it "should produce html entities for < and >" do
    file = File.join($COCO_PATH, 'spec/project/html_entities.rb')
    coverage = {file => [1, 1, 0, nil, 1, 1, nil, nil]}
    formatter = HtmlFormatter.new coverage
    result = formatter.format[file]
    result.match(/a &lt; b<\/pre><\/td>/).should_not == nil
    result.match(/a &gt; b<\/pre><\/td>/).should_not == nil
  end
  
end

describe HtmlIndexFormatter do
  it "should respond to format" do
    formatter = HtmlIndexFormatter.new(COVERAGE_30_70, [])
    formatter.respond_to?(:format).should == true
  end
  
  it "should build the index.html" do
    formatter = HtmlIndexFormatter.new(COVERAGE_30_70, [])
    formatter.format.start_with?('<!DOCTYPE html>').should == true
  end
end

describe ColoredString do
  it "should act as a string" do
    instance = ColoredString.new
    instance.kind_of?(String).should == true
  end
  
  it "should accept a string on instanciation" do
    instance = ColoredString.new 'azerty'
    instance.should == 'azerty'
  end
  
  it "should redify a string" do
    string = ColoredString.new 'azerty'
    string.red.should == "\e[31mazerty\e[0m"
  end
  
  it "should yellowify a string" do
    string = ColoredString.new 'azerty'
    string.yellow.should == "\e[33mazerty\e[0m"
  end
end
