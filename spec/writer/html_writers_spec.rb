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
    expect(File.exist?(@coverage_dir)).to eq(false)
  end
  
  it "must create coverage and css dir and css files" do
    HtmlDirectory.new.setup
    expect(File.exist?('coverage/css/coco.css')).to eq(true)
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
    expect(list.include?('a.html')).to eq(true)
    expect(list.include?('b.html')).to eq(true)
    expect(list.include?('c.not_html')).to eq(false)
  end
  
  it "must give the coverage folder" do
    expect(HtmlDirectory.new.coverage_dir).to eq('coverage')
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
    expect(File.exist?('coverage/css/coco.css')).to eq(true)
    expect(File.exist?('coverage/a.html')).to eq(true)
    expect(File.exist?('coverage/q.html')).to eq(true)
  end
  
  it "must only remove coverage dir if it have no files to write" do
    FileUtils.makedirs @coverage_dir
    writer = HtmlFilesWriter.new Hash.new
    writer.write
    expect(File.exist?('coverage')).to eq(false)
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
    expect(File.exist?('coverage/index.html')).to eq(true)
  end
end
