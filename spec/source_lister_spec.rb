# -*- encoding: utf-8 -*-

require './spec/helper'

describe SourceLister do

  it "must accept a list of folder" do
    SourceLister.new(['lib', 'spec'])
  end
  
  it "must accept a single folder" do
    SourceLister.new('lib')
  end
  
  it "must raise an error if a folder doesnt exist" do
    lambda {SourceLister.new(['unknown', 'lib'])}.should raise_error(ArgumentError)
  end
  
  it "must list the rb sources from a single folder" do
    lister = SourceLister.new('spec/project/3_rb_files')
    list = lister.list
    list.size.should == 3
    list.each do |file|
      file.match(/.rb$/).should_not == nil
    end
  end
  
  it "must list the rb sources from a list of folders" do
    lister = SourceLister.new(['spec/project/3_rb_files', 'spec/project/4_rb_files'])
    list = lister.list
    list.size.should == 7
    list.each do |file|
      file.match(/.rb$/).should_not == nil
    end
  end

end
