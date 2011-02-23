require './spec/helper'

describe Filename do

  it "must transform .rb in .html" do
    rb = File.join(Dir.pwd, "a/b/c.rb")
    html = Filename.rb2html(rb)
    html.should == "_a_b_c.rb.html"
  end
  
end
