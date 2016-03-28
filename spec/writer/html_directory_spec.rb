require './spec/helper'

describe HtmlDirectory do
  let(:coverage_dir) { 'coverage' }
  subject { HtmlDirectory.new }

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

  it "creates coverage and css dir and css files" do
    subject.setup
    expect(File).to exist('coverage/css/coco.css')
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

  it "returns the coverage folder" do
    expect(subject.coverage_dir).to eq(coverage_dir)
  end
end

