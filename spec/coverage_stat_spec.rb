require './spec/helper'

HITS = [nil, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

describe CoverageStat do

  it "must give the cover percents" do
    CoverageStat.coverage_percent(HITS).should == 90
  end

end
