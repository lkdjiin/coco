# -*- encoding: utf-8 -*-

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

  specify { Configuration.new.should respond_to(:user_wants_to_run?) }

  context "with no config file" do
    before :each do
      @config = Configuration.new
    end

    it "should give a default threshold of 100%" do
      @config[:threshold].should == 100
    end

    it "should give a default list of directories" do
      @config[:directories].should == ['lib']
    end

    it "should give an empty default list of files to excludes" do
      @config[:excludes].should == []
    end

    it "should give false for 'single_line_report'" do
      @config[:single_line_report].should be_false
    end

    specify '#user_wants_to_run? returns true' do
      @config.user_wants_to_run?.should be_true
    end
  end

  shared_examples 'COCO environement variable false, zero or nil' do
    it 'should be false if :always_run is false' do
      create_config_new_style always_run: false
      config = Configuration.new
      config.user_wants_to_run?.should be_false
    end

    it 'should be true if :always_run is true' do
      create_config_new_style always_run: true
      config = Configuration.new
      config.user_wants_to_run?.should be_true
    end
  end

  context "with a config file" do
    let!(:threshold) { 50 }

    context "new style" do

      it "should still support the misspelled threeshold config item" do
        create_config_new_style threeshold: threshold
        config = Configuration.new
        config[:threeshold].should == config[:threshold]
        config[:threshold].should == threshold
      end

      it "should read the threshold from .coco.yml file" do
        create_config_new_style threshold: threshold
        config = Configuration.new
        config[:threshold].should == threshold
      end

      it "should ignore old version if new version exists" do
        create_config threshold: 70
        create_config_new_style threshold: threshold
        config = Configuration.new
        config[:threshold].should == threshold
      end

      describe '#user_wants_to_run?' do
        context 'with COCO=something' do
          before { ENV['COCO'] = 'something' }

          def always_run_as(bool)
            create_config_new_style always_run: bool
            config = Configuration.new
            config.user_wants_to_run?.should be_true
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
      config[:threshold].should == threshold
    end

    it "should read the excludes files from .coco file" do
      create_config({:excludes => ['a', 'b']})
      config = Configuration.new
      config[:excludes].should == ['a', 'b']
    end

    it "should read the excludes whole dirs from .coco file" do
      create_config directories: ['spec/project'],
                    excludes: ['spec/project/3_rb_files',
                               'spec/project/4_rb_files']
      config = Configuration.new
      config[:excludes].size.should == 7
    end

    it "should read the excludes whole dirs and files from .coco file" do
      create_config directories: ['spec/project'],
                    excludes: ['spec/project/3_rb_files',
                               'spec/project/six_lines.rb']
      config = Configuration.new
      config[:excludes].size.should == 4
    end

    it "should read 'single_line_report' value from .coco file" do
      create_config single_line_report: true
      config = Configuration.new
      config[:single_line_report].should == true
    end
  end

end
