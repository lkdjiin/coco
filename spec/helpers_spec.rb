# -*- encoding: utf-8 -*-

require './spec/helper'

describe Helpers do

  it "must transform .rb in .html" do
    rb = File.join(Dir.pwd, "a/b/c.rb")
    html = Helpers.rb2html(rb)
    html.should == "_a_b_c.rb.html"
  end
  
  it "must give the index html title" do
    title = Helpers.index_title
    title.match(/^Coco \d\.\d/).should_not == nil
  end
  
  it "must expand a list of filenames" do
    list = Helpers.expand ['a', 'b']
    list.should == [File.join(Dir.pwd, 'a'), File.join(Dir.pwd, 'b')]
  end
  
end
