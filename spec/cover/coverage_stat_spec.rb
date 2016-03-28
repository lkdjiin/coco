require './spec/helper'

HITS = [nil, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

describe CoverageStat do

  it "must give the cover percents" do
    expect(CoverageStat.coverage_percent(HITS)).to eq(90)
  end

  it "must not take nil lines into account" do
    hits_1 = [0, 0, 0, 1, 2, 3]
    hits_2 = [nil, 0, nil, 0, 0, nil, 1, 2, nil, 3, nil]

    result_1 = CoverageStat.coverage_percent(hits_1)
    result_2 = CoverageStat.coverage_percent(hits_2)

    expect(result_1).to eq(result_2)
  end

end
