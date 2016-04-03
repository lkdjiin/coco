require './spec/helper'

describe HtmlIndexFormatter do
  let(:result) {
    instance_double(CoverageResult, count: 123, uncovered_count: 17,
                    average: 60, coverable_files: COVERAGE_30_70)
  }
  let(:formatter) { HtmlIndexFormatter.new(COVERAGE_30_70, [], result) }
  let(:index) { formatter.format }

  describe 'API' do
    specify { expect(formatter).to respond_to :format }
  end

  it "builds the index.html" do
    expect(index).to start_with '<!DOCTYPE html>'
  end

  it 'includes a summary' do
    expect(index).to include('Rate 60%', 'Uncovered 17', 'Files 123')
  end
end

