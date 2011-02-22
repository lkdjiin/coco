require './lib/coco'
COVERAGE_1 = {'the/filename' => [nil, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9]}

describe Coco::ConsoleFormatter do
  
  before :each do
    @formatter = Coco::ConsoleFormatter.new COVERAGE_1
  end
  
  it "must respond to format" do
    @formatter.respond_to?(:format).should == true
  end
  
  it "must return percents and filename" do
    result = @formatter.format
    result.should == "90% the/filename\n"
  end
  
end
