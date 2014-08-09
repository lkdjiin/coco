coco [![Build Status](https://travis-ci.org/lkdjiin/coco.png)](https://travis-ci.org/lkdjiin/coco) [![Gem Version](https://badge.fury.io/rb/coco.png)](http://badge.fury.io/rb/coco) [![Inline docs](http://inch-ci.org/github/lkdjiin/coco.png)](http://inch-ci.org/github/lkdjiin/coco) [![Dependency Status](https://gemnasium.com/lkdjiin/coco.svg)](https://gemnasium.com/lkdjiin/coco)
==============================

Code coverage tool for ruby 1.9.3, 2.0 and 2.1.

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

In your Gemfile:

    gem coco

Or directly:

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
* __exclude_above_threshold__: should we exclude from the console report files with coverage >= threshold

By default, threshold is set to 100, exclude_above_threshold is true and directories is set to 'lib'.

To change the default coco configuration, put a `.coco.yml` file at the root of your project.


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

Advanced configuration
---------------------------------

### When to start coco, and when not to start it
For projects whose complete test suite runs in a matter of seconds,
running code coverage with every test is fine.
But when the test suite takes longer to complete, we typically start to
run a single test more often than the complete suite. In such cases,
the behavior of **coco** could be really annoying: you run a single
test and **coco** reports a infinite list of uncovered files. The
problem here is this is a lie. To avoid this behavior, I recommend to
run code coverage only from time to time, and with the entire test
suite. To do so, **coco** provide the following configuration key:

__always_run__: If true, **coco** will run every time you start a test.
If false, **coco** will run only when you explicitly set an
environement variable named `COCO` with something other than `false`,
`0` or the empty string.

#### Example

Put this in your `.coco.yml` configuration file:

    :always_run: false

Now, when you run:

    rspec spec/

**coco** will no start. To start it, you have to set the
environement variable `COCO`, like this:

    COCO=1 rspec spec/

### Index page URI in your terminal

If your terminal supports opening an URI with a double-clic (or any
other method), you may want to display the URI of the report's index
page. For that, you have to set the __show_link_in_terminal__ key.

#### Example

Put this in your `.coco.yml` configuration file:

    :show_link_in_terminal: true

Now, when running tests, you will see something like the following:

    $ rspec spec
    .............
    [...]

    97% /path/to/bad/tested/file.rb
    See file:///path/to/your/coverage/index.html


Dependencies
--------------------------------

ruby >= 1.9.3


Contributing
--------------------------------

1. Fork it.
2. Create your feature branch **from the development branch**:
   - `git checkout development`
   - `git pull origin development`
   - `git checkout -b my-new-feature`
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a Pull Request.


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

[Gioele](https://github.com/gioele)
