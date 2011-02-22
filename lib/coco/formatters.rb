module Coco

  class ConsoleFormatter
    def self.format coverages
      ret = ''
      coverages.each do |filename, coverage|
        coverable_lines = coverage.select {|e| not e.nil?}
        one_percent = 100.0 / coverable_lines.size
        covered_lines = coverable_lines.select {|e| e > 0}
        coverage_percent = (covered_lines.size * one_percent).to_i
        ret << "#{coverage_percent}% #{filename}\n"
      end
      ret
    end
  end
  
end
