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
end
