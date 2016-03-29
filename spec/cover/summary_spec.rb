require './spec/helper'

describe Summary do
  it "returns a summary string" do
    result = instance_double(CoverageResult, count: 123, uncovered_count: 17,
                             average: 60)
    summary = Summary.new(result)
    expect(summary.to_s).to eq 'Cover 60% | 17 uncovered | 123 files'
  end
end
