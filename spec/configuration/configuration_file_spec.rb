require './spec/helper'
require 'yaml'

describe "Configuration with a config file" do
  subject { Configuration.new }
  let!(:threshold) { 50 }

  after :each do
    FileUtils.rm '.coco.yml', force: true
  end

  def expect_to_have_an_item(k, v)
    create_config k => v
    expect(subject).to include(k => v)
  end

  it "reads the threshold" do
    expect_to_have_an_item(:threshold, threshold)
  end

  it "replaces excludes" do
    expect_to_have_an_item(:excludes, [])
  end

  it "reads the excludes files" do
    expect_to_have_an_item(:excludes, %w(a b))
  end

  it "reads the excludes whole dirs" do
    create_config include: ['spec/project'],
                  excludes: ['spec/project/3_rb_files',
                             'spec/project/4_rb_files']
    expect(subject[:excludes].size).to eq(7)
  end

  it "reads the excludes whole dirs and files" do
    create_config include: ['spec/project'],
                  excludes: ['spec/project/3_rb_files',
                             'spec/project/six_lines.rb']
    expect(subject[:excludes].size).to eq(4)
  end

  it "reads 'single_line_report' value" do
    expect_to_have_an_item(:single_line_report, true)
  end

  it "reads 'exclude_above_threshold' value" do
    expect_to_have_an_item(:exclude_above_threshold, false)
  end

  it "reads the theme" do
    expect_to_have_an_item(:theme, 'dark')
  end

  context "when the theme is missing" do
    it "falls back to default" do
      create_config theme: 'missing'
      v = $VERBOSE; $VERBOSE = nil
      config = Configuration.new
      $VERBOSE = v
      expect(config).to include(theme: 'light')
    end
  end

  shared_examples 'COCO environment variable false, zero or nil' do
    it 'is false when :always_run is false' do
      create_config always_run: false
      expect(subject).not_to run_this_time
    end

    it 'is true when :always_run is true' do
      create_config always_run: true
      expect(subject).to run_this_time
    end
  end

  describe '#run_this_time?' do
    context 'with COCO=something' do
      before { ENV['COCO'] = 'something' }

      it 'is true when :always_run is false' do
        create_config always_run: false
        expect(subject).to run_this_time
      end

      it 'is true when :always_run is true' do
        create_config always_run: true
        expect(subject).to be_run_this_time
      end
    end

    context 'with COCO=' do
      before do ENV['COCO'] = '' end
      include_examples 'COCO environment variable false, zero or nil'
    end

    context 'with COCO=0' do
      before do ENV['COCO'] = '0' end
      include_examples 'COCO environment variable false, zero or nil'
    end

    context 'with COCO=false' do
      before do ENV['COCO'] = 'false' end
      include_examples 'COCO environment variable false, zero or nil'
    end
  end

end
