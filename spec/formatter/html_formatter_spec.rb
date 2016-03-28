require './spec/helper'

describe HtmlFormatter do

  it "should respond to format" do
    formatter = HtmlFormatter.new COVERAGE_70
    expect(formatter.respond_to?(:format)).to eq(true)
  end

  it "should return the right number of html file(s)" do
    formatter = HtmlFormatter.new COVERAGE_30_70
    result = formatter.format
    expect(result.size).to eq(2)
  end

  it "should return html file(s)" do
    formatter = HtmlFormatter.new COVERAGE_70
    result = formatter.format
    result.each {|k, v| expect(v.start_with?('<!DOCTYPE html>')).to eq(true) }
  end

  # Bug 13
  it "should produce html entities for < and >" do
    file = File.join(Coco::ROOT, 'spec/project/html_entities.rb')
    coverage = {file => [1, 1, 0, nil, 1, 1, nil, nil]}
    formatter = HtmlFormatter.new coverage
    result = formatter.format[file]
    expect(result.match(/a &lt; b<\/pre><\/td>/)).not_to eq(nil)
    expect(result.match(/a &gt; b<\/pre><\/td>/)).not_to eq(nil)
  end

end

