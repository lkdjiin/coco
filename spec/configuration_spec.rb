require './spec/helper'
require 'yaml'

describe Configuration do

  before :each do
    FileUtils.rm '.coco', force: true
    FileUtils.rm '.coco.yml', force: true
  end

  after :each do
    FileUtils.rm '.coco', force: true
    FileUtils.rm '.coco.yml', force: true
  end

  specify { expect(Configuration.new).to respond_to(:user_wants_to_run?) }

  context "with no config file" do
    before :each do
      @config = Configuration.new
    end

    it "should give a default threshold of 100%" do
      expect(@config[:threshold]).to eq(100)
    end

    it "should give a default list of directories" do
      expect(@config[:directories]).to eq(['lib'])
    end

    it "should give the default list of directories to excludes" do
      @config[:excludes].each {|file| expect(file =~ /spec|test/).to eq(0) }
    end

    it "should give false for 'single_line_report'" do
      expect(@config[:single_line_report]).to be false
    end

    specify '#user_wants_to_run? returns true' do
      expect(@config.user_wants_to_run?).to be true
    end

    it "give false for 'show_link_in_terminal'" do
      expect(@config[:show_link_in_terminal]).to be false
    end

    it "give true for 'exclude_above_threshold'" do
      expect(@config[:exclude_above_threshold]).to be true
    end


  end

  shared_examples 'COCO environement variable false, zero or nil' do
    it 'should be false if :always_run is false' do
      create_config always_run: false
      config = Configuration.new
      expect(config.user_wants_to_run?).to be false
    end

    it 'should be true if :always_run is true' do
      create_config always_run: true
      config = Configuration.new
      expect(config.user_wants_to_run?).to be true
    end
  end

  context "with a config file" do
    let!(:threshold) { 50 }

    context "new style" do

      it "should still support the misspelled threeshold config item" do
        create_config threeshold: threshold
        v = $VERBOSE; $VERBOSE = nil
        config = Configuration.new
        $VERBOSE = v
        expect(config[:threeshold]).to eq(config[:threshold])
        expect(config[:threshold]).to eq(threshold)
      end

      it "should read the threshold from .coco.yml file" do
        create_config threshold: threshold
        config = Configuration.new
        expect(config[:threshold]).to eq(threshold)
      end

      # TODO: remove once old version is no longer supported
      it "should ignore old version if new version exists" do
        create_config_old_style threshold: 70
        create_config threshold: threshold
        config = Configuration.new
        expect(config[:threshold]).to eq(threshold)
      end

      describe '#user_wants_to_run?' do
        context 'with COCO=something' do
          before { ENV['COCO'] = 'something' }

          def always_run_as(bool)
            create_config always_run: bool
            config = Configuration.new
            expect(config.user_wants_to_run?).to be true
          end

          it 'should be true if :always_run is false' do
            always_run_as false
          end

          it 'should be true if :always_run is true' do
            always_run_as true
          end
        end

        context 'with COCO=' do
          before { ENV['COCO'] = '' }
          include_examples 'COCO environement variable false, zero or nil'
        end

        context 'with COCO=0' do
          before { ENV['COCO'] = '0' }
          include_examples 'COCO environement variable false, zero or nil'
        end

        context 'with COCO=false' do
          before { ENV['COCO'] = 'false' }
          include_examples 'COCO environement variable false, zero or nil'
        end

      end

    end

    it "should read the threshold from .coco file" do
      create_config threshold: threshold
      config = Configuration.new
      expect(config[:threshold]).to eq(threshold)
    end

    it "replaces excludes" do
      create_config({:excludes => []})
      config = Configuration.new
      expect(config[:excludes]).to eq([])
    end

    it "should read the excludes files from .coco file" do
      create_config({:excludes => ['a', 'b']})
      config = Configuration.new
      expect(config[:excludes]).to eq(['a', 'b'])
    end

    it "should read the excludes whole dirs from .coco file" do
      create_config directories: ['spec/project'],
                    excludes: ['spec/project/3_rb_files',
                               'spec/project/4_rb_files']
      config = Configuration.new
      expect(config[:excludes].size).to eq(7)
    end

    it "should read the excludes whole dirs and files from .coco file" do
      create_config directories: ['spec/project'],
                    excludes: ['spec/project/3_rb_files',
                               'spec/project/six_lines.rb']
      config = Configuration.new
      expect(config[:excludes].size).to eq(4)
    end

    it "should read 'single_line_report' value from .coco file" do
      create_config single_line_report: true
      config = Configuration.new
      expect(config[:single_line_report]).to eq(true)
    end

    it "should read 'exclude_above_threshold' value from .coco file" do
      create_config exclude_above_threshold: false
      config = Configuration.new
      expect(config[:exclude_above_threshold]).to be false
    end
  end

end
