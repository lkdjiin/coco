require './spec/helper'

describe ConsoleFormatter do

  let(:coverable) {
    {'a' => [1, 1], 'b' => [0, 1, 1], 'c' => [0, 1, 1, 1]}
  }
  let(:not_enough) {
    {'b' => [0, 1, 1], 'c' => [0, 1, 1, 1]}
  }
  let(:cr) { instance_double(CoverageResult, coverable_files: coverable,
                             not_covered_enough: not_enough) }

  let(:config_single) { {single_line_report: true} }
  let(:config_multi) do
    {single_line_report: false, output_directory: 'coverage'}
  end

  def result(uncovered = [], threshold = 100, conf = config_multi)
    ConsoleFormatter.new(uncovered, threshold, cr, conf).format
  end

  describe 'API' do
    before do
      @subject = ConsoleFormatter.new(['a', 'b', 'c'], 100, cr, config_single)
    end

    specify { expect(@subject).to respond_to :format }
    specify { expect(@subject).to respond_to :link }
  end

  it "returns percents and filename" do
    expect(result).to include("\e[33m67% b\e[0m")
  end

  it "returns percents and filename and uncovered" do
    expect(result(['a'])).to include("\e[31m0% a\e[0m")
  end

  it "sorts by percentage" do
    expect(result).to include("\e[33m67% b\e[0m\n\e[33m75% c\e[0m")
  end

  it "sorts by percentage uncovered" do
    expect(result(%w(a z))).to include("\e[31m0% a\e[0m\n" \
                              "\e[31m0% z\e[0m\n" \
                              "\e[33m67% b\e[0m\n" \
                              "\e[33m75% c\e[0m")
  end

  it "puts in green when >= threshold" do
    expect(result(%w(a b), 70)).to include("\e[32m75% c\e[0m")
  end

  context "when it is a single line report" do

    context "with some uncovered files" do
      it "returns the summary" do
        expected = "\e[33mCover 40.28% | 3 uncovered | 6 files\e[0m"
        expect(result(%w(a b c), 100, config_single)).to eq(expected)
      end
    end

    context "with no uncovered files" do
      it "returns the summary" do
        expect(result([], 100, config_single))
          .to include("Cover", "uncovered", "files")
      end
    end

  end

  describe 'index file link' do
    it "returns a local link to index" do
      formatter = ConsoleFormatter.new([], 100, cr, config_multi)
      link = formatter.link

      expect(link).to include 'See file:///', 'coverage/index.html'
    end
  end

end
