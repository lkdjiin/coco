require './lib/coco'
HITS = [nil, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

describe Coco::CoverageStat do

  it "must give the cover percents" do
    Coco::CoverageStat.coverage_percent(HITS).should == 90
  end

end
