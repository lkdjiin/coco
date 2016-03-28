require './spec/helper'

RAW_RESULT = {
  '/external/1' => [1],
  '/external/2' => [1],
  "#{File.join(Dir.pwd, 'internal/one')}" => [0, 1],
  "#{File.join(Dir.pwd, 'internal/two')}" => [0, 1]
}

RAW_RESULT_2 = {
  '/external/1' => [1],
  '/external/2' => [1],
  "#{File.join(Dir.pwd, 'internal/one')}" => [0, 1],
  "#{File.join(Dir.pwd, 'internal/two')}" => [1, 1]
}

describe CoverageResult do

  describe 'API' do
    let(:result) { described_class.new({threshold: 80}, RAW_RESULT) }
    specify { expect(result).to respond_to :all_from_domain }
    specify { expect(result).to respond_to :covered_from_domain }
  end

  it "refuses negative threshold" do
    expect {
      CoverageResult.new({:threshold => -1}, RAW_RESULT)
    }.to raise_error(ArgumentError)
  end

  it "accepts threshold above 100%" do
    expect {
      CoverageResult.new({:threshold => 101}, RAW_RESULT)
    }.not_to raise_error
  end

  it "excludes external sources" do
    result = CoverageResult.new({:threshold => 90}, RAW_RESULT)
    good_hash = result.all_from_domain

    expect(good_hash.size).to eq(2)
    expect(good_hash).to eq({
      "#{File.join(Dir.pwd, 'internal/one')}" => [0, 1],
      "#{File.join(Dir.pwd, 'internal/two')}" => [0, 1]
    })
  end

  it "excludes files user don't need" do
    config = {:threshold => 90, :excludes => ['internal/two']}
    result = CoverageResult.new(config, RAW_RESULT)
    good_hash = result.all_from_domain

    expect(good_hash.size).to eq(1)
    expect(good_hash).to eq({
      "#{File.join(Dir.pwd, 'internal/one')}" => [0, 1]
    })
  end

  it 'excludes sources above threshold' do
    result = CoverageResult.new({:threshold => 90,
                                 :exclude_above_threshold => true},
                                 RAW_RESULT_2)
    good_hash = result.covered_from_domain

    expect(good_hash.size).to eq(1)
    expect(good_hash[File.join(Dir.pwd, 'internal/one')]).to eq([0, 1])
  end

  it 'includes sources above threshold' do
    result = CoverageResult.new({:threshold => 90,
                                 :exclude_above_threshold => false},
                                 RAW_RESULT_2)
    good_hash = result.covered_from_domain

    expect(good_hash.size).to eq(2)
    expect(good_hash[File.join(Dir.pwd, 'internal/one')]).to eq([0, 1])
  end

end
