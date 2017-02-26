require './spec/helper'

RSpec.describe Project do
  after { FileUtils.rm '.coco.yml', force: true }

  context "with config exit_if_low_coverage = true" do
    it "exits with error code if coverage is less than expected" do
      create_config({exit_if_coverage_below: 87})
      output = StringIO.new
      project = Project.new(COVERAGE_50, output)
      cr = CoverageResult.new({:threshold => 100}, COVERAGE_70)

      allow(project).to receive(:report_on_console) { nil }
      allow(project).to receive(:report_in_html) { nil }
      allow(project).to receive(:result) { cr }

      begin
        project.run
      rescue SystemExit => ex
        red_code = "31m"
        message = "Sadly, the code coverage is below the required value of 87%"
        expect(output.string).to match "#{red_code}#{message}"
        expect(ex.status).to eq Project::EXIT_ON_LOW_COVERAGE_CODE
      else
        expect(true).to eq false # We really want to exit!
      end
    end
  end

  context "with config exit_if_low_coverage = false" do
    it "doesnt exit with error code if coverage is less than expected" do
      project = Project.new(COVERAGE_50, STDOUT)
      cr = CoverageResult.new({:threshold => 100}, COVERAGE_70)

      allow(project).to receive(:report_on_console) { nil }
      allow(project).to receive(:report_in_html) { nil }
      allow(project).to receive(:result) { cr }

      expect { project.run }.not_to raise_error
    end
  end
end
