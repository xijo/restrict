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

require 'denied'
require 'denied/rspec/matcher'

RSpec.configure do |config|
  config.after do
    ExampleController.restrictions = []
  end
end

# Mimics the behavior of ActionController::Base
class FakeController
  attr_accessor :action_name, :current_user
  cattr_accessor :before_filters

  def self.before_filter(filter)
    self.before_filters ||= []
    before_filters << filter
  end
end

FakeUser = Struct.new(:foo)

class ExampleController < FakeController
  include Denied::Rails::Controller

  def falsy
    false
  end

  def truthy
    true
  end
end
