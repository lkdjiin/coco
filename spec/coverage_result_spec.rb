# -*- encoding: utf-8 -*-

require './spec/helper'

RAW_RESULT = {
  '/external/1' => [1],
  '/external/2' => [1],
  "#{File.join(Dir.pwd, 'internal/one')}" => [0, 1],
  "#{File.join(Dir.pwd, 'internal/two')}" => [0, 1]
}

RAW_RESULT_2 = {
  '/external/1' => [1],
  '/external/2' => [1],
  "#{File.join(Dir.pwd, 'internal/one')}" => [0, 1],
  "#{File.join(Dir.pwd, 'internal/two')}" => [1, 1]
}

describe CoverageResult do

  it "must refuse negative threeshold" do
    lambda {CoverageResult.new({:threeshold => -1}, RAW_RESULT)}.should raise_error(ArgumentError)
  end
  
  it "must accept threeshold above 100%" do
    lambda {CoverageResult.new({:threeshold => 101}, RAW_RESULT)}.should_not raise_error
  end
  
  it "must exclude external sources" do
    result = CoverageResult.new({:threeshold => 90}, RAW_RESULT)
    good_hash = result.all_from_domain
    good_hash.size.should == 2
    good_hash.should == {"#{File.join(Dir.pwd, 'internal/one')}" => [0, 1],
                          "#{File.join(Dir.pwd, 'internal/two')}" => [0, 1]}
  end
  
  it "must exclude files user don't need" do
    config = {:threeshold => 90, :excludes => ['internal/two']}
    result = CoverageResult.new(config, RAW_RESULT)
    good_hash = result.all_from_domain
    good_hash.size.should == 1
    good_hash.should == {"#{File.join(Dir.pwd, 'internal/one')}" => [0, 1]}
  end
  
  it "must exclude sources above threeshold" do
    result = CoverageResult.new({:threeshold => 90}, RAW_RESULT_2)
    good_hash = result.covered_from_domain
    good_hash.size.should == 1
    good_hash[File.join(Dir.pwd, 'internal/one')].should == [0, 1]
  end
  
end
