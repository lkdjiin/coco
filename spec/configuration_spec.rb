# -*- encoding: utf-8 -*-

require './spec/helper'
require 'yaml'

describe Configuration do

  before :each do
    FileUtils.rm '.coco', force: true
  end
  
  after :each do
    FileUtils.rm '.coco', force: true
  end
  
  context "with no config file" do
    before :each do
      @config = Configuration.new
    end
    
    it "should give a default threeshold of 100%" do
      @config[:threeshold].should == 100
    end
    
    it "should give a default list of directories" do
      @config[:directories].should == ['lib']
    end
    
    it "should give an empty default list of files to excludes" do
      @config[:excludes].should == []
    end
    
    it "should give false for 'single_line_report'" do
      @config[:single_line_report].should be_false
    end
  end
  
  context "with a config file" do
    it "should read the threeshold from .coco file" do
      create_config threeshold: 50
      config = Configuration.new
      config[:threeshold].should == 50
    end
    
    it "should read the excludes files from .coco file" do
      create_config({:excludes => ['a', 'b']})
      config = Configuration.new
      config[:excludes].should == ['a', 'b']
    end
    
    it "should read the excludes whole dirs from .coco file" do
      create_config directories: ['spec/project'], 
                    excludes: ['spec/project/3_rb_files', 'spec/project/4_rb_files']
      config = Configuration.new
      config[:excludes].size.should == 7
    end
    
    it "should read the excludes whole dirs and files from .coco file" do
      create_config directories: ['spec/project'], 
                    excludes: ['spec/project/3_rb_files', 'spec/project/six_lines.rb']
      config = Configuration.new
      config[:excludes].size.should == 4
    end
    
    it "should read 'single_line_report' value from .coco file" do
      create_config single_line_report: true
      config = Configuration.new
      config[:single_line_report].should == true
    end
  end
  
end
