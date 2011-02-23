require './spec/helper'

describe HtmlDirectory do

  before :all do
    @coverage_dir = 'coverage'
  end
  
  before :each do
    FileUtils.remove_dir @coverage_dir if File.exist? @coverage_dir
  end
  
  after :each do
    FileUtils.remove_dir @coverage_dir if File.exist? @coverage_dir
  end
  
  it "must delete coverage dir if any" do
    FileUtils.makedirs @coverage_dir
    HtmlDirectory.new.clean
    File.exist?(@coverage_dir).should == false
  end
  
  it "must create coverage dir and css file" do
    HtmlDirectory.new.setup
    File.exist?('coverage/coco.css').should == true
  end
  
  def make_fake_dir
    FileUtils.makedirs @coverage_dir
    FileUtils.touch File.join(@coverage_dir, 'a.html')
    FileUtils.touch File.join(@coverage_dir, 'b.html')
    FileUtils.touch File.join(@coverage_dir, 'c.not_html')
  end
  
  it "must list html files" do
    make_fake_dir
    list = HtmlDirectory.new.list
    list.include?('a.html').should == true
    list.include?('b.html').should == true
    list.include?('c.not_html').should == false
  end
  
  it "must give the coverage folder" do
    HtmlDirectory.new.coverage_dir.should == 'coverage'
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

describe HtmlIndexWriter do
  before :all do
    @coverage_dir = 'coverage'
  end
  
  before :each do
    FileUtils.remove_dir @coverage_dir if File.exist? @coverage_dir
  end
  
  after :each do
    FileUtils.remove_dir @coverage_dir if File.exist? @coverage_dir
  end
  
  it "must write the index file" do
    FileUtils.makedirs @coverage_dir
    HtmlIndexWriter.new('content').write
    File.exist?('coverage/index.html').should == true
  end
end
