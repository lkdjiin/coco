# -*- encoding: utf-8 -*-

require './spec/helper'
require 'yaml'

describe Configuration do

  before :each do
    FileUtils.rm '.coco', :force => true
  end
  
  def create_config options
    f = File.new('.coco', "w")
    f.write options.to_yaml
		f.close
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
  
end
