require './spec/helper'

describe HtmlDirectory do

  before :all do
    @coverage_dir = 'coverage'
  end
  
  it "must delete coverage dir if any" do
    FileUtils.makedirs @coverage_dir
    HtmlDirectory.new.clean
    File.exist?(@coverage_dir).should == false
  end
  
  it "must create coverage dir and css file" do
    FileUtils.remove_dir @coverage_dir if File.exist? @coverage_dir
    HtmlDirectory.new.setup
    File.exist?('coverage/coco.css').should == true
  end
end



describe HtmlFilesWriter do
  before :all do
    @hash = { 'a' => 'azerty', 'q' => 'qwerty'}
    @coverage_dir = 'coverage'
  end
  
  it "must write all files" do
    writer = HtmlFilesWriter.new @hash
    writer.write
    File.exist?('coverage/coco.css').should == true
    File.exist?('coverage/a.html').should == true
    File.exist?('coverage/q.html').should == true
  end
  
  it "must only remove coverage dir if it have no files to write" do
    FileUtils.makedirs @coverage_dir
    writer = HtmlFilesWriter.new Hash.new
    writer.write
    File.exist?('coverage').should == false
  end
  
end
