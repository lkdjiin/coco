require 'coco/project'
require 'coco/theme'
require 'coco/formatter'
require 'coco/cover'
require 'coco/writer'
require 'coco/helpers'
require 'coco/configuration'
require 'coco/lister'
require 'coco/deprecated_message'

require 'coverage'

# Public: Main namespace of Coco, a code coverage utilily for
# Ruby 2.x.
#
module Coco
  ROOT = File.expand_path(File.dirname(__FILE__) + '/..').freeze
end

Coverage.start

# The coverage's analysis happens at the very end of the test suite.
#
at_exit do
  Coco::Project.run(Coverage.result)
end
