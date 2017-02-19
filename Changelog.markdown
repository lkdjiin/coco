Next version (Unreleased)
=================================================

## Added

* It's now possible to exit (with code status 2) from coco when the coverage
  is less than the threshold. This feature allow the build to fail in
  continuous integration. This behavior is controlled by the option
  `:exit_if_low_coverage` and is false by default.

## Changed

* The coverage rate is now displayed in decimal format. So it's 12.34% instead
  of 12%. This change affect the console summary as well as the index page of
  the HTML report.


v0.14.0 (2016-04-16)
=================================================

## Added

* Add a summary (rate of coverage, number of uncovered files and total number of
  files) in the HTML report and on the console.
* You can now view all files in the HTML report, even those equal to or above
  the threshold. This feature allow you to view the line's hit for every files.
* Add support for Ruby 2.3.
* Now you can choose between a dark theme and the (old) light one, for the HTML
  report. The choice is made with a new configuration key : `:theme`. The
  default theme is the light one.
* Add acceptance testing with Cucumber.
* [Experimental] Add support for head of MRI Ruby.
* [Experimental] Add support for Rubinius 2.x.
* [Experimental] Add support for (latest version of) JRuby.
* [Experimental] Add support for OSX.

## Changed

* The single line report (on the console) is now the default behavior.
* The license is now MIT.
* Move contributors list in a file.

## Removed

* Removed the license's mention in the reports's index.
* Removed the gems reek and flay from the development dependencies.

## Deprecated

* The configuration key `directories` will be removed in a future version, the
  new key to use is `include`.
* The configuration key `excludes` will be removed in a future version, the
  new key to use is `exclude`.


v0.13.0  (2015-07-03)
=================================================

* Drop support for Ruby 1.9.3.
* Remove base path in index file of the HTML report for greater
  readability.
* Exclude spec and test folders by default from the coverage. It was
  weird to sometimes see test files reported.
* Improve the theme.
* In HTML report, highlight each lines of code, not only the green ones.
* Ligthen the first part of the path in the index file of the HTML
  report for greater readability.


v0.12.0  (2014-08-09)
=================================================

* Allows display of file whose coverage is more than threshold in the
  console.
* Highlights hitted lines on mouse over in the HTML report.


v0.11.0  (2014-05-24)
=================================================

* Properly escape HTML in report.
* Implements hit counters.
* Output warnings for deprecated features.
* Development/test
  - Improve documentation for developers.
  - Add Rake tasks for documentation. 
  - Fix a random failing test
  - Remove command line garbage after tests
  - Update developer dependencies

v0.10.0  (2014-05-03)
=================================================

* Drop support for Ruby 1.9.2.
* Add some rake tasks for development.
* Add a «Contributing» section in the README.


v0.9  (2014-02-02)
=================================================

* New configuration option: `always_run`, to control when to start coco
  and when to not start it.
* Add link in the terminal.
* New configuration option: `show_link_in_terminal`, to display the
  report's index page URI in the terminal.
* Partially converts developer's documentation in tomdoc format.
* Update gemspec for ruby version 2.1


v0.8  (2013-12-21)
=================================================

* Html report
  - Improve appearance of index page.
	- Emphasize filenames in index page.
	- No longer needs css files fro Yahoo.
* Bugfix: Html files now have a doctype.


v0.7.1  (2013-07-05)
=================================================

* Bugfix: Output a nicer message on bad config
* Bugfix: Threshold misspelling. Preserving compatibility for the
  "threeshold" spelling too. 


v0.7  (2013-06-19)
=================================================

* Bugfix: `single_line_report` option is now silent if there is nothing to
  report
* Improve report styling (a bit)
* Default threshold is now 100%
* Config file is renamed to '.coco.yml', to benefit of syntax highlighting


v0.6  (2011-10-30)
=================================================

* Added an option `single_line_report`


v0.5.1  (2011-08-08)
=================================================

* Fix a bug where excluding a whole folder from the report does not worked


v0.5  (2011-03-14)
=================================================

* can exclude a whole folder of ruby files from the report
* works with unit/test framework


v0.4.2  (2011-03-01)
=================================================

* Fix bug #14 Sometimes text exit on the right from table in html report
* Fix bug #13 '<' and '>' are not escaped in hml report
* Fix bug #12 No link to web site in html files


v0.4.1  (2011-02-27)
=================================================

* Quick fix, add forgotten images for html menu


v0.4  (2011-02-26)
=================================================

* Add colors to console output (nix only)
* It can exclude unwanted files from the report


v0.3  (2011-02-25)
=================================================

* Report sources not covered at all
* Configurable via a simple yaml file: threshold and source directories
* UTF-8 compliant
* Misc: sort index.html and console output by percentage, Display
  version in index.html


v0.2  (2011-02-24)
=================================================

* Use coco from rspec with a simple require 'coco'
* Display filenames covered < 90% on console
* Build simple html report only for files covered < 90%
