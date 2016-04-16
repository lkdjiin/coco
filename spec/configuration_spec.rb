require './spec/helper'
require 'yaml'

# See also:
# - `configuration/default_configuration_spec.rb` for the specs of the
#   configuration without a config file.
# - `configuration/configuration_file_spec.rb` for the specs of the
#   configuration involving a config file.
# - `configuration/configuration_legacy_spec.rb` for the specs about
#   deprecated features.
#
describe Configuration do
  describe 'API' do
    it { is_expected.to respond_to :run_this_time? }
  end
end
