# minitest-mark

This is an extension to [minitest](https://github.com/seattlerb/minitest)
which adds the ability to use test marking. This feature is inspired by
[pytest's marks](http://pytest.org/latest/mark.html).


**WARNING:** This is a _proof of concept_. It works, but is not intended --
in its current form -- to be used for production tests.

## Example

### Defining And Running Marks

Define a test with some marks:

```ruby
require "minitest/unit"
require "minitest/mark"

class MyTest < MiniTest::Unit::TestCase
  include MiniTest::Mark

  mark("foo")
  def test_things
    assert true
  end

  mark("bar")
  def test_other
    assert true
  end
end
```

Run them like normal and they'll run, like normal:

    $ rake test
    Loaded suite /Users/mitchellh/.rvm/gems/ruby-1.9.2-p290/bin/rake
    Started
    ..
    Finished in 0.000743 seconds.

    2 tests, 2 assertions, 0 failures, 0 errors, 0 skips

Run with `MARK` environmental variable to target only select marks:

    $ MARK=foo rake test
    Loaded suite /Users/mitchellh/.rvm/gems/ruby-1.9.2-p290/bin/rake
    Started
    .
    Finished in 0.000533 seconds.

    1 tests, 1 assertions, 0 failures, 0 errors, 0 skips
