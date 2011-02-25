# -*- encoding: utf-8 -*-

require './spec/helper'

describe ConsoleFormatter do
  
  it "must respond to format" do
    formatter = ConsoleFormatter.new(COVERAGE_90, ['a', 'b', 'c'])
    formatter.respond_to?(:format).should == true
  end
  
  it "must return percents and filename" do
    formatter = ConsoleFormatter.new(COVERAGE_80, [])
    result = formatter.format
    result.should == "80% the/filename/80"
  end
  
  it "must return percents and filename and uncovered" do
    formatter = ConsoleFormatter.new(COVERAGE_80, ['a'])
    result = formatter.format
    result.should == "0% a\n80% the/filename/80"
  end
  
  it "must sort by percentage" do
    formatter = ConsoleFormatter.new(COVERAGE_100_90_80, [])
    result = formatter.format
    result.should == "80% the/filename/80\n90% the/filename/90\n100% the/filename/100"
  end
  
  it "must sort by percentage uncovered too" do
    formatter = ConsoleFormatter.new(COVERAGE_100_90_80, ['a', 'b'])
    result = formatter.format
    result.should == "0% a\n0% b\n80% the/filename/80\n90% the/filename/90\n100% the/filename/100"
  end
  
end

describe HtmlFormatter do

  it "must respond to format" do
    formatter = HtmlFormatter.new COVERAGE_70
    formatter.respond_to?(:format).should == true
  end
  
  it "must return the right number of html file(s)" do
    formatter = HtmlFormatter.new COVERAGE_30_70
    result = formatter.format
    result.size.should == 2
  end
  
  it "must return html file(s)" do
    formatter = HtmlFormatter.new COVERAGE_70
    result = formatter.format
    result.each {|k, v| v.start_with?('<html>').should == true }
  end
  
end

describe HtmlIndexFormatter do
  it "must respond to format" do
    formatter = HtmlIndexFormatter.new(COVERAGE_30_70)
    formatter.respond_to?(:format).should == true
  end
  
  it "must build the index.html" do
    formatter = HtmlIndexFormatter.new(COVERAGE_30_70)
    formatter.format.start_with?('<html>').should == true
  end
end
