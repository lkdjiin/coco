coco [![Build Status](https://travis-ci.org/lkdjiin/coco.png)](https://travis-ci.org/lkdjiin/coco) [![Gem Version](https://badge.fury.io/rb/coco.png)](http://badge.fury.io/rb/coco) [![Inline docs](http://inch-ci.org/github/lkdjiin/coco.png)](http://inch-ci.org/github/lkdjiin/coco) [![Dependency Status](https://gemnasium.com/lkdjiin/coco.svg)](https://gemnasium.com/lkdjiin/coco)
==============================

— *«If it's well-covered it doesn't mean it's well-tested!»* —

# Code coverage tool for ruby 2.x

## Install

In your Gemfile:

    gem 'coco'

Or directly:

    gem install coco

*NOTE: If you're using a Gemfile, don't `:require => false`*

And in case you want to test the latest development:

    gem 'coco', github: 'lkdjiin/coco', branch: 'development'

## Usage
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

## Basic Configuration

Configuration is done via a YAML file. You can configure:

* __theme__: Choose between a light and a dark theme for the HTML report
* __threshold__: the percentage threshold
* __include__: the directories from where coco will search for untested source files
* __exclude__: a list of files and/or directories to exclude from the report, if any
* __single_line_report__: style of the report in the console

By default, threshold is set to 100, the list of directories is set to `['lib']`,
no files are excluded and the console report is a single line one.

To change this default configuration, put a `.coco.yml` file at the root of your project.

### Theme

You can choose between a light and a dark theme. The light theme is the
default one. For a dark theme, add this line in the configuration file:

    :theme: dark

**Light theme**

![light](theme-light.png)

**Dark theme**

![dark](theme-dark.png)

### Threshold

Add the following line to your .coco.yml file to set the threshold to 80%.

    :threshold: 80

Only files under 80% of coverage will be directly reported in the report.
I strongly advice to use the default threshold (100%).

### Directories Included

Add the following lines to your .coco.yml file to set the directories to both
'lib' and “ext':

    :include: 
    - lib
    - ext

### Files and Directories Excludes

Add the following lines to your .coco.yml file to exclude a file from the
report:

    :exclude:
    - lib/project/file1.rb

Add the following lines to your .coco.yml file to exclude a whole folder's
content from the report:

    :exclude:
    - config/initializers

Of course you can mix files and folders:

    :exclude:
    - path/to/file1
    - path/to/file2
    - folder1
    - path/to/folder2

### Single line report

By default, the console's reports a brief, one line, summary. If instead, you
want to display the coverage of all files under the threeshold, put this line
in your .coco.yml file:

    :single_line_report: false

Advice: Don't do this!

## Sample config for a Rails project

    :include: 
    - app
    - custom_dir
    - lib
    :exclude:
    - config/initializers

_Note: YAML is very punctilious with the syntax. In particular, paid attention
to not put any leading spaces or tab at all._


## Advanced configuration

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

### Premature exit if coverage is under a particular threshold

If you're using some kind of continuous integration, there is some chance you
would like the build to fail if the coverage is under a particular threshold.
In such case you want to set the `exit_if_coverage_below` option.

#### Example

Put this in your `.coco.yml` configuration file:

    :exit_if_coverage_below: 95

This will make coco fail if the coverage percentage is below 95%.


### See coverage of all files in the console

By default, with a multilines report style on the console, Coco will display
only the files with a coverage above the threshold. And as the threshold is
100% by default, nothing will be displayed if your test suite is 100% covered.
This could be annoying for some people, or worst, you could even feel like Coco
doing something the wrong way.

So, to display in green the covered files, put this in your `.coco.yml`
configuration file:

    :exclude_above_threshold: false

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


## How is this different than [SimpleCov](https://github.com/colszowka/simplecov) ?

I designed Coco from the start to have only the features I need. And I don't
need much: 95% of the time, all I want is a tiny one line summary in my console.

It's easier. Add a single line of code at the start of your spec helper and
you are good to go.

It's faster. Because Coco has no dependencies and less features, analyzing and
reporting are so fast you don't even notice them.

To synthesize, if you have big needs, give SimpleCov a try ; if you have small
needs, give Coco a try.


## Contributing

1. Fork it.
2. Create your feature branch
   - `git pull origin master`
   - `git checkout -b my-new-feature`
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a Pull Request.


## License
MIT, see LICENSE.


## Questions and/or Comments

Feel free to email [Xavier Nayrac](mailto:xavier.nayrac@gmail.com)
with any questions, or contact me on [twitter](https://twitter.com/lkdjiin).

