require './spec/helper'

describe HtmlIndexWriter do
  let(:coverage_dir) { 'coverage' }
  let(:config) { {theme: 'light', output_directory: 'coverage'} }

  after :each do
    FileUtils.remove_dir(coverage_dir) if File.exist?(coverage_dir)
  end

  it "writes the index file" do
    FileUtils.makedirs(coverage_dir)
    HtmlIndexWriter.new('content', config).write

    expect(File).to exist('coverage/index.html')
  end
end
