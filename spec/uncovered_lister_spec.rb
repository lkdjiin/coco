require './spec/helper'

SOURCE_FILES_1 = [
  File.join(Coco::ROOT, 'spec/project/ten_lines.rb'),
  File.join(Coco::ROOT, 'spec/project/six_lines.rb'),
  File.join(Coco::ROOT, 'spec/project/uncovered1.rb'),
  File.join(Coco::ROOT, 'spec/project/uncovered2.rb')
]

describe UncoveredLister do

  it "must give the list of uncovered files" do
    uncov = UncoveredLister.new(SOURCE_FILES_1, COVERAGE_30_70)
    list = uncov.list
    list.include?(File.join(Coco::ROOT, 'spec/project/uncovered1.rb')).should == true
    list.include?(File.join(Coco::ROOT, 'spec/project/uncovered2.rb')).should == true
  end
end
