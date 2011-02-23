$LOAD_PATH.unshift File.dirname(__FILE__)
$COCO_PATH = File.expand_path(File.dirname(__FILE__)) + '/..'
require 'coco/formatters'
require 'coco/coverage_stat'
require 'coverage'

module Coco

  @threeshold = 90
  
  def Coco.exclude_external_sources(raw_coverage_result)
    here = Dir.pwd
    raw_coverage_result.select {|key, value| key.start_with? here}
  end
  
  def Coco.exclude_sources_above_threeshold(raw_coverage_result)
    raw_coverage_result.select {|key, value| 
      CoverageStat.coverage_percent(value) < @threeshold
    }
  end
  
end

Coverage.start

at_exit do
  # Must do all that stuff in a class (Coco::Main, for example)
  
  # Keep only the files from the testing project
  result = Coco.exclude_external_sources(Coverage.result)
  
  # Keep only the files under threeshold
  result = Coco.exclude_sources_above_threeshold result
  
  # Generate console output
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
