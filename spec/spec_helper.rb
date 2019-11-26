require 'simplecov'
require 'byebug'

SimpleCov.profiles.define 'gem' do
  add_filter '/spec/'
  add_filter '/autotest/'
  add_group 'Libraries', '/lib/'
end
SimpleCov.start 'gem'

require 'restrict'
require 'restrict/rspec/matcher'
require 'restrict/rspec/shared_example'

RSpec.configure do |config|
  config.after do
    ExampleController.__send__(:restrict_restrictions).clear
    InheritingController.__send__(:restrict_restrictions).clear
    BottomLineController.__send__(:restrict_restrictions).clear
  end
end

# Mimics the behavior of ActionController::Base
class FakeController
  attr_accessor :action_name, :user_signed_in
  cattr_accessor :before_filters

  def user_signed_in?
    !!@user_signed_in
  end

  def self.before_filter(filter)
    self.before_filters ||= []
    before_filters << filter
  end
  singleton_class.send(:alias_method, :before_action, :before_filter)
end

class ExampleController < FakeController
  include Restrict::Rails::Controller

  def falsy
    false
  end

  def truthy
    true
  end
end

class InheritingController < ExampleController
  include Restrict::Rails::Controller
end

class BottomLineController < InheritingController
  include Restrict::Rails::Controller
end
