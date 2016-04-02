require './spec/helper'

describe HtmlFilesWriter do
  let(:coverage_dir) { 'coverage' }

  it "writes all files" do
    HtmlFilesWriter.new({'a' => 'azerty', 'q' => 'qwerty'}).write

    expect(File).to exist("#{coverage_dir}/css/coco.css")
    expect(File).to exist("#{coverage_dir}/a.html")
    expect(File).to exist("#{coverage_dir}/q.html")
  end

  it "removes coverage dir when there is no files to write" do
    FileUtils.makedirs(coverage_dir)
    HtmlFilesWriter.new(Hash.new).write

    expect(File).not_to exist(coverage_dir)
  end

  context 'with the default light theme' do
    it 'includes the CSS' do
      HtmlFilesWriter.new({'a' => 'azerty'}).write
      css_file = File.read("#{coverage_dir}/css/coco.css")
      expect(css_file).to include("Default light theme for Coco")
    end
  end

  context 'with the dark theme' do
    it 'includes the CSS' do
      HtmlFilesWriter.new({'a' => 'azerty'}, 'dark').write
      css_file = File.read("#{coverage_dir}/css/coco.css")
      expect(css_file).to include("Dark theme for Coco")
    end
  end

end

