# -*- encoding: utf-8 -*-

require './spec/helper'
require 'yaml'

describe Configuration do

  before :each do
    FileUtils.rm '.coco', :force => true
  end
  
  after :each do
    FileUtils.rm '.coco', :force => true
  end
  
  it "must give a default threeshold of 90%" do
    config = Configuration.new
    config[:threeshold].should == 90
  end
  
  it "must read the threeshold from .coco file" do
    create_config({:threeshold => 50})
    config = Configuration.new
    config[:threeshold].should == 50
  end
  
  it "must give a default list of directories" do
    config = Configuration.new
    config[:directories].should == ['lib']
  end
  
  it "must give an empty default list of files to excludes" do
    config = Configuration.new
    config[:excludes].should == []
  end
  
  it "must read the excludes files from .coco file" do
    create_config({:excludes => ['a', 'b']})
    config = Configuration.new
    config[:excludes].should == ['a', 'b']
  end
  
  it "must read the excludes whole dirs from .coco file" do
    create_config({:directories => ['spec/project'], 
      :excludes => ['spec/project/3_rb_files', 'spec/project/4_rb_files']})
    config = Configuration.new
    config[:excludes].size.should == 7
  end
  
  it "must read the excludes whole dirs and files from .coco file" do
    create_config({:directories => ['spec/project'], 
      :excludes => ['spec/project/3_rb_files', 'spec/project/six_lines.rb']})
    config = Configuration.new
    config[:excludes].size.should == 4
  end
  
end
