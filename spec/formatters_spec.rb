require './spec/helper'



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
    result.should == "80% the/filename/80\n"
  end
  
end

describe HtmlFormatter do

  it "must respond to format" do
    formatter = HtmlFormatter.new COVERAGE_70
    formatter.respond_to?(:format).should == true
  end
  
  it "must return the right number of html file(s)" do
    formatter = HtmlFormatter.new COVERAGE_30_70
    result = formatter.format
    result.size.should == 2
  end
  
  it "must return html file(s)" do
    formatter = HtmlFormatter.new COVERAGE_70
    result = formatter.format
    result.each {|k, v| v.start_with?('<html>').should == true }
  end
  
end
