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

end

