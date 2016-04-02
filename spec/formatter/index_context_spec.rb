require './spec/helper'

describe IndexContext do
  it "returns the binding" do
    title = "a"
    covered = "b"
    uncovered = "c"
    summary = "d"

    context = IndexContext.new(title, covered, uncovered, summary).variables

    expect(eval("@title", context)).to eq "a"
    expect(eval("@covered", context)).to eq "b"
    expect(eval("@uncovered", context)).to eq "c"
    expect(eval("@summary", context)).to eq "d"
  end
end
