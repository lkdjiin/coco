require './spec/helper'
require 'yaml'

describe "Configuration legacy" do

  before do
    @v = $VERBOSE; $VERBOSE = nil
  end

  after do
    FileUtils.rm '.coco', force: true
    FileUtils.rm '.coco.yml', force: true
    $VERBOSE = @v
  end

  # TODO Remove the support of .coco file in version 1.0.
  #
  describe 'Old config file .coco' do
    it "ignores .coco if .coco.yml exists" do
      create_config_old_style threshold: 70
      create_config threeshold: 99
      expect(Configuration.new).to include(threshold: 99)
    end
  end

  # Standard way for testing old/new config key syntax.
  #
  shared_examples "it still supports" do |old_key, new_key, value|
    it "still supports #{old_key}" do
      create_config(old_key => value)
      config = Configuration.new
      expect(config[old_key]).to eq(config[new_key])
      expect(config[new_key]).to eq(value)
    end
  end

  # TODO Remove the support of threeshold config key in version 1.0.
  #
  describe 'threeshold/threshold' do
    include_examples 'it still supports', :threeshold, :threshold, 99
  end

  # TODO Remove the support of directories config key in version 2.0.
  #
  describe 'directories/include' do
    include_examples 'it still supports', :directories, :include, %w( foo bar )
  end

  # TODO Remove the support of excludes config key in version 2.0.
  #
  describe 'excludes/exclude' do
    include_examples 'it still supports', :excludes, :exclude, %w( foo )
  end

end
