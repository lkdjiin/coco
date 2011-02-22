require './spec/helper'

COVERAGE_90 = {'the/filename' => [nil, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9]}
COVERAGE_80 = {'the/filename' => [nil, 0, 0, 2, 3, 4, 5, 6, 7, 8, 9]}

describe ConsoleFormatter do
  
  before :each do
    @formatter = ConsoleFormatter.new COVERAGE_90
  end
  
  it "must respond to format" do
    @formatter.respond_to?(:format).should == true
  end
  
  it "must return percents and filename if percent < 90%" do
    formatter = ConsoleFormatter.new COVERAGE_80
    result = formatter.format
    result.should == "80% the/filename\n"
  end
  
  it "must return empty string if percent >= 90%" do
    result = @formatter.format
    result.should == ""
  end
  
end

describe HtmlFormatter do

  before :each do
    @formatter = HtmlFormatter.new COVERAGE_90
  end

  #~ it "must return html file" do
    #~ result = @formatter.format
    #~ puts result
  #~ end
  
end
