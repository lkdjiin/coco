require './spec/helper'

describe HtmlIndexFormatter do
  let(:result) {
    instance_double(CoverageResult, coverable_files: COVERAGE_50_70)
  }
  let(:formatter) { HtmlIndexFormatter.new([], result) }
  let(:index) { formatter.format }

  describe 'API' do
    specify { expect(formatter).to respond_to :format }
  end

  it "builds the index.html" do
    expect(index).to start_with '<!DOCTYPE html>'
  end

  it 'includes a summary' do
    expect(index).to include('Rate 60.00%', 'Uncovered 0', 'Files 2')
  end
end
