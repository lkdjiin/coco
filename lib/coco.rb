$LOAD_PATH.unshift File.dirname(__FILE__)
$COCO_PATH = File.expand_path(File.dirname(__FILE__)) + '/..'
require 'coco/formatters'
require 'coco/coverage_stat'
require 'coco/coverage_result'
require 'coverage'

module Coco
end

Coverage.start

at_exit do
  result = Coco::CoverageResult.new(90).result(Coverage.result)
  puts Coco::ConsoleFormatter.new(result).format
  
  # Generate html files
  html_files = Coco::HtmlFormatter.new(result).format
  FileUtils.remove_dir 'coverage' if File.exist? 'coverage'
  FileUtils.makedirs 'coverage'
  FileUtils.copy File.join($COCO_PATH, 'template/coco.css'), 'coverage'
  html_files.each do |filename, html|
    f = File.new(File.join('coverage', filename.sub(Dir.pwd, '').tr('/\\', '_') + '.html'), "w")
    f.write html
    f.close
  end
end
