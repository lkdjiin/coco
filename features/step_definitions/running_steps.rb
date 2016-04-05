Given(/^a default configuration$/) do
  # Do nothing. The default configuration is inside Coco.
end

When(/^I run the project$/) do
  @summary = StringIO.new
  coverage_result = {}
  Coco::Project.run(coverage_result, @summary)
end

Then(/^I can see the summary$/) do
  expect(@summary.string).to include('Cover', 'uncovered', 'files')
end
