require './spec/helper'
require 'yaml'

describe Configuration do

  RSpec::Matchers.define :run_this_time do
    match do |obj|
      obj.run_this_time? == true
    end
  end

  subject { Configuration.new }

  after :each do
    FileUtils.rm '.coco', force: true
    FileUtils.rm '.coco.yml', force: true
  end

  describe 'API' do
    it { is_expected.to respond_to :run_this_time? }
  end

  context "with no config file" do
    it { is_expected.to include(:threshold => 100) }
    it { is_expected.to include(:directories => ['lib']) }
    it { is_expected.to include(:single_line_report => true) }
    it { is_expected.to run_this_time }
    it { is_expected.to include(:show_link_in_terminal => false) }
    it { is_expected.to include(:exclude_above_threshold => true) }
    it { is_expected.to include(:theme => 'light') }

    it "returns directories excluded by default" do
      expect(subject[:excludes]).to all(match(/spec|test/))
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

  context "with a config file" do
    let!(:threshold) { 50 }

    context "new style" do

      it "still supports the misspelled threeshold config item" do
        create_config threeshold: threshold
        v = $VERBOSE; $VERBOSE = nil
        config = Configuration.new
        $VERBOSE = v
        expect(config[:threeshold]).to eq(config[:threshold])
        expect(config[:threshold]).to eq(threshold)
      end

      it "reads the threshold from .coco.yml file" do
        create_config threshold: threshold
        expect(subject).to include(:threshold => threshold)
      end

      # TODO: remove once old version is no longer supported
      it "ignores old version if new version exists" do
        create_config_old_style threshold: 70
        create_config threshold: threshold
        expect(subject).to include(:threshold => threshold)
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
          before { ENV['COCO'] = '' }
          include_examples 'COCO environment variable false, zero or nil'
        end

        context 'with COCO=0' do
          before { ENV['COCO'] = '0' }
          include_examples 'COCO environment variable false, zero or nil'
        end

        context 'with COCO=false' do
          before { ENV['COCO'] = 'false' }
          include_examples 'COCO environment variable false, zero or nil'
        end

      end

    end

    it "reads the threshold from .coco file" do
      create_config threshold: threshold
      expect(subject).to include(:threshold => threshold)
    end

    it "replaces excludes" do
      create_config({:excludes => []})
      expect(subject[:excludes]).to eq([])
    end

    it "reads the excludes files from .coco file" do
      create_config({:excludes => ['a', 'b']})
      expect(subject[:excludes]).to eq(['a', 'b'])
    end

    it "reads the excludes whole dirs from .coco file" do
      create_config directories: ['spec/project'],
                    excludes: ['spec/project/3_rb_files',
                               'spec/project/4_rb_files']
      expect(subject[:excludes].size).to eq(7)
    end

    it "reads the excludes whole dirs and files from .coco file" do
      create_config directories: ['spec/project'],
                    excludes: ['spec/project/3_rb_files',
                               'spec/project/six_lines.rb']
      expect(subject[:excludes].size).to eq(4)
    end

    it "reads 'single_line_report' value from .coco file" do
      create_config single_line_report: true
      expect(subject).to include(single_line_report: true)
    end

    it "reads 'exclude_above_threshold' value from .coco file" do
      create_config exclude_above_threshold: false
      expect(subject).to include(exclude_above_threshold: false)
    end

    it "reads the theme from .coco file" do
      create_config theme: 'dark'
      expect(subject).to include(theme: 'dark')
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

  end

end
