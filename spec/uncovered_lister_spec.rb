require './spec/helper'

SOURCE_FILES_1 = [
  File.join($COCO_PATH, 'spec/project/ten_lines.rb'),
  File.join($COCO_PATH, 'spec/project/six_lines.rb'),
  File.join($COCO_PATH, 'spec/project/uncovered1.rb'),
  File.join($COCO_PATH, 'spec/project/uncovered2.rb')
]

describe UncoveredLister do

  it "must give the list of uncovered files" do
    uncov = UncoveredLister.new(SOURCE_FILES_1, COVERAGE_30_70)
    list = uncov.list
    list.include?(File.join($COCO_PATH, 'spec/project/uncovered1.rb')).should == true
    list.include?(File.join($COCO_PATH, 'spec/project/uncovered2.rb')).should == true
  end
end
