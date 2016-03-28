require './spec/helper'

describe SourceLister do

  before :each do
    FileUtils.rm '.coco.yml', :force => true
  end

  after :each do
    FileUtils.rm '.coco.yml', :force => true
  end

  it "must accept a list of folder" do
    create_config({:directories => ['lib', 'spec']})
    SourceLister.new(Configuration.new)
  end

  it "must accept a single folder" do
    create_config(:directories => 'lib')
    SourceLister.new(Configuration.new)
  end

  it "must raise an error if a folder doesnt exist" do
    create_config(:directories => ['lib', 'unknown'])
    expect {
      SourceLister.new(Configuration.new)
    }.to raise_error(ArgumentError)
  end

  it "must list the rb sources from a single folder" do
    create_config(:directories => 'spec/project/3_rb_files', :excludes => [])
    lister = SourceLister.new(Configuration.new)
    list = lister.list
    expect(list.size).to eq(3)
    list.each do |file|
      expect(file.match(/.rb$/)).not_to eq(nil)
    end
  end

  it "must list the rb sources user dont want" do
    create_config(:directories => 'spec/project/3_rb_files',
                  :excludes => ['spec/project/3_rb_files/1.rb'])
    lister = SourceLister.new(Configuration.new)
    list = lister.list
    expect(list.size).to eq(2)
    list.each do |file|
      expect(file.match(/.rb$/)).not_to eq(nil)
    end
  end

  it "must exclude a whole directory" do
    create_config(:directories => 'spec/project',
                  :excludes => ['spec/project/3_rb_files',
                                'spec/project/4_rb_files'])
    lister = SourceLister.new(Configuration.new)
    list = lister.list
    expect(list.size).to eq(3)
    list.map! {|x| File.basename(x)}
    expect(list.include?('html_entities.rb')).to eq(true)
    expect(list.include?('six_lines.rb')).to eq(true)
    expect(list.include?('ten_lines.rb')).to eq(true)
  end

  it "must list the rb sources from a list of folders" do
    create_config(:directories => ['spec/project/3_rb_files',
                                   'spec/project/4_rb_files'],
                  :excludes => [])
    lister = SourceLister.new(Configuration.new)
    list = lister.list
    expect(list.size).to eq(7)
    list.each do |file|
      expect(file.match(/.rb$/)).not_to eq(nil)
    end
  end

end
