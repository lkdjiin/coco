require './spec/helper'

describe Helpers do

  describe '.rb2html' do

    it "should transform .rb in .html" do
      rb = File.join(Dir.pwd, "a/b/c.rb")
      html = Helpers.rb2html(rb)
      html.should == "a_b_c.rb.html"
    end

  end

  describe '.index_title' do

    it "should give the index html title" do
      title = Helpers.index_title
      title.match(/Code coverage/).should_not == nil
    end

  end

  describe '.expand' do

    it "should expand a list of filenames" do
      list = Helpers.expand ['a', 'b']
      list.should == [File.join(Dir.pwd, 'a'), File.join(Dir.pwd, 'b')]
    end

  end

  describe '.name_for_html' do

    it "should format the filename for html" do
      rb = File.join(Dir.pwd, "a/b/c.rb")
      html = Helpers.name_for_html(rb)
      html.should == "a/b/<b>c.rb</b>"
    end

  end

end
