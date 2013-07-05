coco [![Build Status](https://travis-ci.org/lkdjiin/coco.png)](https://travis-ci.org/lkdjiin/coco) [![Gem Version](https://badge.fury.io/rb/coco.png)](http://badge.fury.io/rb/coco)
==============================

Code coverage tool for ruby 1.9.2, 1.9.3 and 2.0.

Features
--------------------------------

* Use it from rspec or test/unit with a simple `require 'coco'`
* Works with Rails
* Display names of uncovered files on console
* _Simple_ html report _only_ for uncovered files
* Report sources that have no tests
* UTF-8 compliant
* Configurable via a simple yaml file
* Colorized console output (nix only)


Install
--------------------------------

    gem install coco

Usage
--------------------------------
Require the coco library at the beginning of your tests:

    require 'coco'

Usually you do this only once, by putting this line in an spec_helper.rb,
or test_helper.rb (or whatever you named it).

###View report

After your tests, coco will display a short report in the console window, like this one:

    $ rake test
    [...]
    26 examples, 0 failures
    0% /home/xavier/project/lib/iprune.rb
    0% /home/xavier/project/lib/iprune/iprune.rb
    46% /home/xavier/project/lib/parser/prunille.rb
    $

If there is some files reported in the console, coco will create a `coverage/`
folder at the root of the project. Browse the `coverage/index.html` to access
a line by line report.

**Be careful!** Any `coverage` folder at the root of your project will be
deleted without warning!

_Note: files with a coverage of 0% are only listed in index.html ; there
is no line by line report for such files._

Configuration
----------------------------------

Configuration is done via a YAML file. You can configure:

* __threshold__: the percentage threshold
* __directories__: the directories from where coco will search for untested source files
* __excludes__: a list of files to exclude from the report
* __single_line_report__: the report's style

By default, threshold is set to 100 and directories is set to 'lib'.

To change the default coco configuration, put a `.coco.yml` file at the root of your project.

_Earlier versions of coco used to use `.coco` instead of `.coco.yml`, as of
version 0.7, using `.coco` is deprecated. Reason is `.yml` extension allow
for syntax highlighting._


###Sample config for a Rails project

    :directories: 
    - app
    - lib
    :excludes:
    - spec
    - config/initializers
    :single_line_report: true

_Note: YAML is very punctilious with the syntax. In particular, paid attention
to not put any leading spaces or tab at all._

See [more examples](https://github.com/lkdjiin/coco/wiki) on the wiki.

Dependencies
--------------------------------

ruby >= 1.9.2


License
--------------------------------
GPLv3, see COPYING.

Questions and/or Comments
--------------------------------

Feel free to email [Xavier Nayrac](mailto:xavier.nayrac@gmail.com)
with any questions, or contact me on [twitter](https://twitter.com/lkdjiin).

Contributors
--------------------------------

[sunaku (Suraj N. Kurapati)](https://github.com/sunaku)

[Daniel Rice](https://github.com/BigNerdRanchDan)
