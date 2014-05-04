# -*- encoding: utf-8 -*-

module Coco

  # Give statistics about an array of lines hit.
  #
  # An "array of lines hit" is an array of integers, possibly nil.
  # Such array is obtain from Coverage.result.
  #
  # Each integer represent the state of a source line:
  # * nil: source line will never be reached (like comments)
  # * 0: source line could be reached, but was not
  # * 1 and above: number of time the source line has been reached
  module CoverageStat
    extend self

    def number_of_covered_lines(hits)
      hits.select {|elem| elem > 0 }.size
    end

    def coverage_percent(hits)
      hits = hits.compact
      return 0 if hits.empty?
      one_percent = 100.0 / hits.size
      (number_of_covered_lines(hits) * one_percent).to_i
    end

  end

end
