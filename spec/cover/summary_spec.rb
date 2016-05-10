require './spec/helper'

describe Summary do
  let(:coverable) {
    {'a' => [1, 1], 'b' => [0, 1, 1], 'c' => [0, 1, 1, 1]}
  }

  it "returns a summary string" do
    result = instance_double(CoverageResult, coverable_files: coverable)
    uncovered = ['untested']
    summary = Summary.new(result, uncovered)
    expect(summary.to_s).to eq 'Cover 60.42% | 1 uncovered | 4 files'
  end
end
