require './spec/helper'

describe HtmlFormatter do

  it "returns the right number of html file(s)" do
    result = HtmlFormatter.new(COVERAGE_50_70).format
    expect(result.size).to eq(2)
  end

  it "returns html file(s)" do
    result = HtmlFormatter.new(COVERAGE_70).format
    expect(result.values).to all(start_with('<!DOCTYPE html>'))
  end

  # Bug 13
  it "produces html entities for < and >" do
    file = File.join(Coco::ROOT, 'spec/project/html_entities.rb')
    coverage = {file => [1, 1, 0, nil, 1, 1, nil, nil]}
    formatter = HtmlFormatter.new(coverage)
    result = formatter.format[file]

    expect(result).to match(/a &lt; b<\/pre><\/td>/)
    expect(result).to match(/a &gt; b<\/pre><\/td>/)
  end

end

