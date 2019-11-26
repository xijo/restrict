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
  restrict :delete, unless: :goodie_manager?

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
  2. If `user_signed_in?` the access to take is allowed
  3. If `user_signed_in?` but `goodie_manager?` returns false, then `Restrict::AccessDenied` will be raised
  4. If `user_signed_in?` and `goodie_manager?` is true, the access is allowed

### Restrict all actions

```ruby
restrict
```

This one will apply to all actions on this controller. It takes the `unless` option as well.

### Configuration

```ruby
# Default is :user_signed_in?
Restrict.config.authentication_validation_method = :admin_session_exists?
```

You may set the method that is used to figure out whether a user is signed in or not to whatever you like, however it's default is `:user_signed_in?` which is the most common (devise) method in use.

### Inheritance

A controller will respect all restrictions that are applied to its ancestors.

You may implement a set of rules in a `BaseController` and refine them in subclasses later on.

Please note: it is not possible yet to revert previously added restrictions, that means
if a restriction on `show` is added in a class and another one in the subclass **BOTH** apply.

## Contributing

You know how this works and bonus points for feature branches!
