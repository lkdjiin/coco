# -*- encoding: utf-8 -*-

require './spec/helper'

describe SourceLister do

  before :each do
    FileUtils.rm '.coco', :force => true
  end
  
  after :each do
    FileUtils.rm '.coco', :force => true
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
    lambda {SourceLister.new(Configuration.new)}.should raise_error(ArgumentError)
  end
  
  it "must list the rb sources from a single folder" do
    create_config(:directories => 'spec/project/3_rb_files')
    lister = SourceLister.new(Configuration.new)
    list = lister.list
    list.size.should == 3
    list.each do |file|
      file.match(/.rb$/).should_not == nil
    end
  end
  
  it "must list the rb sources user dont want" do
    create_config(:directories => 'spec/project/3_rb_files', :excludes => ['spec/project/3_rb_files/1.rb'])
    lister = SourceLister.new(Configuration.new)
    list = lister.list
    list.size.should == 2
    list.each do |file|
      file.match(/.rb$/).should_not == nil
    end
  end
  
  it "must list the rb sources from a list of folders" do
    create_config(:directories => ['spec/project/3_rb_files', 'spec/project/4_rb_files'])
    lister = SourceLister.new(Configuration.new)
    list = lister.list
    list.size.should == 7
    list.each do |file|
      file.match(/.rb$/).should_not == nil
    end
  end

end
