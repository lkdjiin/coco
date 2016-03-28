require './lib/coco'
require 'fileutils'
require "rspec/expectations"

RSpec.configure do |config|
  config.before(:suite) { FileUtils.rm '.coco.yml', :force => true }

  config.after(:suite) { create_config(:excludes => ['lib']) }
end

include Coco

COVERAGE_100 = {'the/filename/100' => [nil, 1, 1, 2, 3, 4, 5, 6, 7, 8, 9]}
COVERAGE_90 = {'the/filename/90' => [nil, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9]}
COVERAGE_80 = {'the/filename/80' => [nil, 0, 0, 2, 3, 4, 5, 6, 7, 8, 9]}
COVERAGE_70 = {File.join(Coco::ROOT, 'spec/project/ten_lines.rb') =>
               [0, 0, 0, 3, 4, 5, 6, 7, 8, 9]}
COVERAGE_30 = {File.join(Coco::ROOT, 'spec/project/six_lines.rb') =>
               [0, 0, 0, 4, 5, 6]}
COVERAGE_30_70 = COVERAGE_30.merge(COVERAGE_70)
COVERAGE_100_90_80 = COVERAGE_80.merge(COVERAGE_90).merge(COVERAGE_100)

def create_config_old_style options
  f = File.new('.coco', "w")
  f.write options.to_yaml
  f.close
end

def create_config options
  f = File.new('.coco.yml', "w")
  f.write options.to_yaml
  f.close
end
