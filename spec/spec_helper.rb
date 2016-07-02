require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

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

RSpec.configure do |config|
  config.after do
    ExampleController.restrictions = []
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
