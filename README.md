# Restrict

A rails controller extension, that gives you the possibility to restrict access to your controller actions.

[![Build Status](https://secure.travis-ci.org/xijo/restrict.png?branch=master)](https://travis-ci.org/xijo/restrict) [![Gem Version](https://badge.fury.io/rb/restrict.png)](http://badge.fury.io/rb/restrict) [![Code Climate](https://codeclimate.com/github/xijo/restrict.png)](https://codeclimate.com/github/xijo/restrict) [![Code Climate](https://codeclimate.com/github/xijo/restrict/coverage.png)](https://codeclimate.com/github/xijo/restrict)

## Installation

    gem 'restrict'

## Compatibility

Works with rails 3 and 4 and all versions every ruby 2.

## Usage

```ruby
class GoodiesController < ApplicationController
  restrict :take
  restrict :delete, allow_if: :goodie_manager?

  def take
    # Grab a goodie
  end

  def delete
    # Remove all the goodies
  end

  private

  def goodie_manager?
    # Your domain implementation
  end
end
```

What that does:
  1. Any anonymous access to one of both methods will raise `Restrict::LoginRequired`
  2. If a `current_user` exists the access to take is allowed
  3. If a `current_user` exists but `goodie_manager?` returns false, then `Restrict::AccessDenied` will be raised
  4. If a `current_user` exists and `goodie_manager?` is true, the access is allowed

## Todos/Ideas

* make `current_user` configurable
* introduce `any_action` option

## Contributing

You know how this works and bonus points for feature branches!
