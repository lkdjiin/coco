# -*- encoding: utf-8 -*-

require './spec/helper'

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
    file = File.join(Coco::ROOT, 'spec/project/html_entities.rb')
    coverage = {file => [1, 1, 0, nil, 1, 1, nil, nil]}
    formatter = HtmlFormatter.new coverage
    result = formatter.format[file]
    result.match(/a &lt; b<\/pre><\/td>/).should_not == nil
    result.match(/a &gt; b<\/pre><\/td>/).should_not == nil
  end

end

