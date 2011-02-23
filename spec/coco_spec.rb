require './spec/helper'

RAW_RESULT = {
  '/external/1' => [],
  '/external/2' => [],
  "#{File.join(Dir.pwd, 'internal/one')}" => []
}

describe Coco do
  it "must exclude external sources" do
    good_list = Coco.exclude_external_sources RAW_RESULT
    good_list.size.should == 1
    good_list.should == {"#{File.join(Dir.pwd, 'internal/one')}" => []}
  end
  
  it "must exclude sources above threeshold" do
    good_list = Coco.exclude_sources_above_threeshold COVERAGE_100_90_80
    good_list.size.should == 1
    good_list['the/filename/80'].should == [nil, 0, 0, 2, 3, 4, 5, 6, 7, 8, 9]
  end
end
