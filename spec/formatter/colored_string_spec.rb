require './spec/helper'

describe ColoredString do
  subject { ColoredString.new('azerty') }

  it "acts as a string" do
    expect(subject).to be_a_kind_of String
  end

  it "makes a string green" do
    expect(subject.green).to eq("\e[32mazerty\e[0m")
  end

  it "makes a string red" do
    expect(subject.red).to eq("\e[31mazerty\e[0m")
  end

  it "makes a string yellow" do
    expect(subject.yellow).to eq("\e[33mazerty\e[0m")
  end
end

