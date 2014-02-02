v0.9  (2014-02-02)
=================================================

* New configuration option: `always_run`, to control when to start coco
  and when to not start it.
+ ajouter link dans le terminal
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

* Bugfix: single_line_report option is now silent if there is nothing to
  report
* Improve report styling (a bit)
* Default threshold is now 100%
* Config file is renamed to '.coco.yml', to benefit of syntax highlighting


v0.6  (2011-10-30)
=================================================

* Added an option 'single_line_report'


v0.5.1  (2011-08-08)
=================================================

* Fix a bug where excluding a whole folder from the report does not worked


v0.5  (2011-03-14)
=================================================

* can exclude a whole folder of ruby files from the report
* works with unit/test framework


v0.4.2  (2011-03-01)
=================================================

Minor bug fixes 
---------------
* #14: sometimes text exit on the right from table in html report
* #13: '<' and '>' are not escaped in hml report
* #12: no link to web site in html files


v0.4.1  (2011-02-27)
=================================================

* Quick fix, add forgotten images for html menu


v0.4  (2011-02-26)
=================================================

* add colors to console output (*nix only)
* it can exclude unwanted files from the report


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
