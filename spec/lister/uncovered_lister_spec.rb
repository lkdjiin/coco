require './spec/helper'

SOURCE_FILES_1 = [
  File.join(Coco::ROOT, 'spec/project/ten_lines.rb'),
  File.join(Coco::ROOT, 'spec/project/six_lines.rb'),
  File.join(Coco::ROOT, 'spec/project/uncovered1.rb'),
  File.join(Coco::ROOT, 'spec/project/uncovered2.rb')
]

describe UncoveredLister do

  it "returns the list of uncovered files" do
    list = UncoveredLister.new(SOURCE_FILES_1, COVERAGE_30_70).list

    file1 = File.join(Coco::ROOT, 'spec/project/uncovered1.rb')
    file2 = File.join(Coco::ROOT, 'spec/project/uncovered2.rb')

    expect(list).to include(file1, file2)
  end
end
