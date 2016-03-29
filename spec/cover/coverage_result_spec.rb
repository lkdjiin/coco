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
  let(:config) { {threshold: 90} }

  describe 'API' do
    let(:result) { described_class.new(config, RAW_RESULT) }

    specify { expect(result).to respond_to :coverable_files }
    specify { expect(result).to respond_to :covered_from_domain }
    specify { expect(result).to respond_to :count }
    specify { expect(result).to respond_to :uncovered_count }
    specify { expect(result).to respond_to :average }

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
  end

  describe '#coverable_files' do
    it "excludes external sources" do
      result = CoverageResult.new(config, RAW_RESULT)
      good_hash = result.coverable_files

      expect(good_hash.size).to eq(2)
      expect(good_hash).to eq({
        "#{File.join(Dir.pwd, 'internal/one')}" => [0, 1],
        "#{File.join(Dir.pwd, 'internal/two')}" => [0, 1]
      })
    end

    it "excludes files user don't need" do
      config = {:threshold => 90, :excludes => ['internal/two']}
      result = CoverageResult.new(config, RAW_RESULT)
      good_hash = result.coverable_files

      expect(good_hash.size).to eq(1)
      expect(good_hash).to eq({
        "#{File.join(Dir.pwd, 'internal/one')}" => [0, 1]
      })
    end
  end

  describe '#covered_from_domain' do
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

  describe '#count' do
    it "counts «coverable files" do
      raw = {
        '/external/1' => [1],
        '/external/2' => [1],
        '/external/3' => [1],
        "#{File.join(Dir.pwd, 'internal/one')}" => [0, 1],
        "#{File.join(Dir.pwd, 'internal/two')}" => [0, 1]
      }
      result = CoverageResult.new(config, raw)
      expect(result.count).to eq 2
    end
  end

  describe '#average' do
    it 'computes the average' do
      raw = {
        "#{File.join(Dir.pwd, 'a')}" => [0, 0],       # 0%
        "#{File.join(Dir.pwd, 'b')}" => [1, 1],       # 100%
        "#{File.join(Dir.pwd, 'c')}" => [0, 1, 1],    # 2/3 * 100%
        "#{File.join(Dir.pwd, 'd')}" => [0, 1, 1, 1], # 75%
      }
      result = CoverageResult.new(config, raw)
      # formula is (0 + 100 + 2/3*100 + 75) / 4
      expect(result.average).to eq(60)
    end

    context 'when there is no files' do
      it 'returns zero' do
        result = CoverageResult.new(config, {})
        expect(result.average).to eq(0)
      end
    end
  end

  describe '#uncovered_count' do
    it 'counts files with 0% of coverage rate' do
      raw = {
        "#{File.join(Dir.pwd, 'a')}" => [0, 0],
        "#{File.join(Dir.pwd, 'b')}" => [0, 0, 1],
        "#{File.join(Dir.pwd, 'c')}" => [1, 1, 1],
      }
      result = CoverageResult.new(config, raw)

      expect(result.uncovered_count).to eq(1)
    end
  end

end
