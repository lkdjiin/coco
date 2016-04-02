coco [![Build Status](https://travis-ci.org/lkdjiin/coco.png)](https://travis-ci.org/lkdjiin/coco) [![Gem Version](https://badge.fury.io/rb/coco.png)](http://badge.fury.io/rb/coco) [![Inline docs](http://inch-ci.org/github/lkdjiin/coco.png)](http://inch-ci.org/github/lkdjiin/coco) [![Dependency Status](https://gemnasium.com/lkdjiin/coco.svg)](https://gemnasium.com/lkdjiin/coco)
==============================

— *«If it's well-covered it doesn't mean it's well-tested!»* —

Code coverage tool for ruby 2.0, 2.1, 2.2 and 2.3.
=======

Install
--------------------------------

In your Gemfile:

    gem 'coco'

Or directly:

    gem install coco

*NOTE: If you're using a Gemfile, don't `:require => false`*

And in case you want to test the latest development:

    gem 'coco', github: 'lkdjiin/coco', branch: 'development'

Usage
--------------------------------
Require the coco library at the beginning of your tests:

    require 'coco'

Usually you do this only once, by putting this line in an spec_helper.rb,
or test_helper.rb (or whatever you named it).

### View report

After your tests, coco will display a **very** short report in the console
window, like this one:

    $ rake test
    [...]
    26 examples, 0 failures

    Rate 82% | Uncovered 0 | Files 7
    $

coco will also create a `coverage/` folder at the root of the project. Browse
the `coverage/index.html` to access a line by line report.

_Note: files with a coverage of 0% are only listed in index.html ; there
is no line by line report for such files._

Basic Configuration
----------------------------------

Configuration is done via a YAML file. You can configure:

* __theme__: Choose between a light and a dark theme for the HTML report
* __threshold__: the percentage threshold
* __directories__: the directories from where coco will search for untested source files
* __excludes__: a list of files to exclude from the report, if any
* __single_line_report__: style of the report in the console

By default, threshold is set to 100, the list of directories is set to `['lib']`,
no files are excluded and the console report is a single line one.

To change this default configuration, put a `.coco.yml` file at the root of your project.


### Sample config for a Rails project

    :directories: 
    - app
    - lib
    :excludes:
    - config/initializers

_Note: YAML is very punctilious with the syntax. In particular, paid attention
to not put any leading spaces or tab at all._

### Theme

You can choose between a light and a dark theme. The light theme is the
default one. For a dark theme, add this line in the configuration file:

    :theme: dark

**Light theme**

[TODO add a screeshot]

**Dark theme**

[TODO add a screeshot]

See [more configuration examples](https://github.com/lkdjiin/coco/wiki) on the wiki.

Advanced configuration
---------------------------------

### See coverage of all files in the console

By default, with a multilines report style on the console, Coco will display
only the files with a coverage above the threshold. And as the threshold is
100% by default, nothing will be displayed if your test suite is 100% covered.
This could be annoying for some people, or worst, you could even feel like Coco
doing something the wrong way.

So, to display in green the covered files, put this in your `.coco.yml`
configuration file:

    :exclude_above_threshold: false

### When to start coco, and when not to start it

For projects whose complete test suite runs in a matter of seconds, running
code coverage with every test is fine.  But when the test suite takes longer to
complete, we typically start to run a single test more often than the complete
suite. In such cases, the behavior of Coco could be really annoying: you
run a single test and Coco reports a infinite list of uncovered files. The
problem here is this is a lie. To avoid this behavior, I recommend to run code
coverage only from time to time, and with the entire test suite. To do so,
Coco provide the following configuration key:

__always_run__: If true, Coco will run every time you start a test.
If false, Coco will run only when you explicitly set an
environement variable named `COCO` with something other than `false`,
`0` or the empty string.

#### Example

Put this in your `.coco.yml` configuration file:

    :always_run: false

Now, when you run:

    rspec

…Coco will no start. To start it, you have to set the
environement variable `COCO`, like this:

    COCO=1 rspec

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

ruby >= 2.0


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
MIT, see LICENSE.


Questions and/or Comments
--------------------------------

Feel free to email [Xavier Nayrac](mailto:xavier.nayrac@gmail.com)
with any questions, or contact me on [twitter](https://twitter.com/lkdjiin).

