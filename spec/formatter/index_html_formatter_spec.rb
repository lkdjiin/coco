require './spec/helper'

describe HtmlIndexFormatter do
  it "builds the index.html" do
    formatter = HtmlIndexFormatter.new(COVERAGE_30_70, [])

    expect(formatter.format).to start_with '<!DOCTYPE html>'
  end
end

