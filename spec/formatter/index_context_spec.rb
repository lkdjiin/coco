require './spec/helper'

describe IndexContext do
  it "returns the binding" do
    title = "a"
    covered = [[20], [89], [90], [100]]
    uncovered = "c"
    summary = "d"

    context = IndexContext.new(title, covered, uncovered, summary, 90).variables

    expect(eval("@title", context)).to eq "a"
    expect(eval("@covered", context)).to eq [ [20], [89] ]
    expect(eval("@greens", context)).to eq [ [90], [100] ]
    expect(eval("@uncovered", context)).to eq "c"
    expect(eval("@summary", context)).to eq "d"
  end
end
