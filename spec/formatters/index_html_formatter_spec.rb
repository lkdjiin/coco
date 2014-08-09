# -*- encoding: utf-8 -*-

require './spec/helper'

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

