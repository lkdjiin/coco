require './spec/helper'

describe HtmlIndexFormatter do
  it "should respond to format" do
    formatter = HtmlIndexFormatter.new(COVERAGE_30_70, [])
    expect(formatter.respond_to?(:format)).to eq(true)
  end

  it "should build the index.html" do
    formatter = HtmlIndexFormatter.new(COVERAGE_30_70, [])
    expect(formatter.format.start_with?('<!DOCTYPE html>')).to eq(true)
  end
end

