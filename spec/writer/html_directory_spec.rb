require './spec/helper'

describe HtmlDirectory do
  let(:coverage_dir) { 'coverage' }
  subject { HtmlDirectory.new({theme: 'light', output_directory: 'coverage'}) }

  after :each do
    FileUtils.remove_dir(coverage_dir) if File.exist?(coverage_dir)
  end

  describe 'API' do
    it { is_expected.to respond_to :coverage_dir }
    it { is_expected.to respond_to :clean }
    it { is_expected.to respond_to :setup }
    it { is_expected.to respond_to :list }
  end

  it "deletes coverage dir if any" do
    FileUtils.makedirs(coverage_dir)
    subject.clean
    expect(File).not_to exist(coverage_dir)
  end

  it "creates all dirs & files" do
    subject.setup
    expect(File).to exist('coverage/css/coco.css')
    expect(File).to exist('coverage/js/coco.js')
  end

  def make_fake_dir
    FileUtils.makedirs(coverage_dir)
    FileUtils.touch File.join(coverage_dir, 'a.html')
    FileUtils.touch File.join(coverage_dir, 'b.html')
    FileUtils.touch File.join(coverage_dir, 'c.not_html')
  end

  it "lists html files" do
    make_fake_dir
    list = subject.list
    expect(list).to include('a.html', 'b.html')
    expect(list).not_to include('c.not_html')
  end

  describe "coverage directory" do
    context "with a default config" do
      it "returns the default directory" do
        expect(subject.coverage_dir).to eq(coverage_dir)
      end
    end

    context "with overridden config" do
      it "returns the directory" do
        directory = "whatever"
        html_dir = HtmlDirectory.new({output_directory: directory,
                                      theme: "light"})
        expect(html_dir.coverage_dir).to eq(directory)
      end
    end
  end
end
