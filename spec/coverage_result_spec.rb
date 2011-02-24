# -*- encoding: utf-8 -*-

require './spec/helper'

RAW_RESULT = {
  '/external/1' => [1],
  '/external/2' => [1],
  "#{File.join(Dir.pwd, 'internal/one')}" => [0, 1]
}

RAW_RESULT_2 = {
  '/external/1' => [1],
  '/external/2' => [1],
  "#{File.join(Dir.pwd, 'internal/one')}" => [0, 1],
  "#{File.join(Dir.pwd, 'internal/two')}" => [1, 1]
}

describe CoverageResult do

  it "must refuse negative threeshold" do
    lambda {CoverageResult.new(-1)}.should raise_error(ArgumentError)
  end
  
  it "must accept threeshold above 100%" do
    lambda {CoverageResult.new(101)}.should_not raise_error
  end
  
  it "must exclude external sources" do
    good_list = CoverageResult.new(90).result(RAW_RESULT)
    good_list.size.should == 1
    good_list.should == {"#{File.join(Dir.pwd, 'internal/one')}" => [0, 1]}
  end
  
  it "must exclude sources above threeshold" do
    good_list = CoverageResult.new(90).result RAW_RESULT_2
    good_list.size.should == 1
    good_list[File.join(Dir.pwd, 'internal/one')].should == [0, 1]
  end
  
end
