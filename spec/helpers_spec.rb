require './spec/helper'

describe Helpers do

  describe '.rb2html' do
    it "transforms .rb in .html" do
      rb = File.join(Dir.pwd, "a/b/c.rb")
      html = Helpers.rb2html(rb)
      expect(html).to eq("a_b_c.rb.html")
    end
  end

  describe '.index_title' do
    it "gives the index html title" do
      title = Helpers.index_title
      expect(title).to match(/Code coverage/)
    end
  end

  describe '.expand' do
    it "expands a list of filenames" do
      list = Helpers.expand ['a', 'b']
      expect(list).to eq([File.join(Dir.pwd, 'a'), File.join(Dir.pwd, 'b')])
    end
  end

  describe '.name_for_html' do
    it "formats the filename for html" do
      rb = File.join(Dir.pwd, "a/b/c.rb")
      html = Helpers.name_for_html(rb)
      expect(html).to eq("a/b/<b>c.rb</b>")
    end
  end

end
