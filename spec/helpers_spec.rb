require './spec/helper'

describe Helpers do

  describe '.rb2html' do

    it "should transform .rb in .html" do
      rb = File.join(Dir.pwd, "a/b/c.rb")
      html = Helpers.rb2html(rb)
      expect(html).to eq("a_b_c.rb.html")
    end

  end

  describe '.index_title' do

    it "should give the index html title" do
      title = Helpers.index_title
      expect(title.match(/Code coverage/)).not_to eq(nil)
    end

  end

  describe '.expand' do

    it "should expand a list of filenames" do
      list = Helpers.expand ['a', 'b']
      expect(list).to eq([File.join(Dir.pwd, 'a'), File.join(Dir.pwd, 'b')])
    end

  end

  describe '.name_for_html' do

    it "should format the filename for html" do
      rb = File.join(Dir.pwd, "a/b/c.rb")
      html = Helpers.name_for_html(rb)
      expect(html).to eq("a/b/<b>c.rb</b>")
    end

  end

end
