require './spec/helper'
require 'yaml'

describe "Default configuration (no config file)" do
  subject { Configuration.new }

  it { is_expected.to include(:threshold => 100) }
  it { is_expected.to include(:include => ['lib']) }
  it { is_expected.to include(:single_line_report => true) }
  it { is_expected.to run_this_time }
  it { is_expected.to include(:show_link_in_terminal => false) }
  it { is_expected.to include(:exclude_above_threshold => true) }
  it { is_expected.to include(:theme => 'light') }

  it "returns directories excluded by default" do
    expect(subject[:exclude]).to all(match(/spec|test/))
  end
end
