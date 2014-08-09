# -*- encoding: utf-8 -*-

require './spec/helper'

describe ColoredString do
  it "should act as a string" do
    instance = ColoredString.new
    instance.kind_of?(String).should == true
  end

  it "should accept a string on instanciation" do
    instance = ColoredString.new 'azerty'
    instance.should == 'azerty'
  end

  it "should greenify a string" do
    string = ColoredString.new 'azerty'
    string.green.should == "\e[32mazerty\e[0m"
  end

  it "should redify a string" do
    string = ColoredString.new 'azerty'
    string.red.should == "\e[31mazerty\e[0m"
  end

  it "should yellowify a string" do
    string = ColoredString.new 'azerty'
    string.yellow.should == "\e[33mazerty\e[0m"
  end
end

