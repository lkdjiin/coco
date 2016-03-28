require './spec/helper'

describe ColoredString do
  it "should act as a string" do
    instance = ColoredString.new
    expect(instance.kind_of?(String)).to eq(true)
  end

  it "should accept a string on instanciation" do
    instance = ColoredString.new 'azerty'
    expect(instance).to eq('azerty')
  end

  it "should greenify a string" do
    string = ColoredString.new 'azerty'
    expect(string.green).to eq("\e[32mazerty\e[0m")
  end

  it "should redify a string" do
    string = ColoredString.new 'azerty'
    expect(string.red).to eq("\e[31mazerty\e[0m")
  end

  it "should yellowify a string" do
    string = ColoredString.new 'azerty'
    expect(string.yellow).to eq("\e[33mazerty\e[0m")
  end
end

