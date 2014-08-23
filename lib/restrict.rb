require 'active_support'
require 'active_support/core_ext/class/attribute.rb'

require 'restrict/version'
require 'restrict/configuration'
require 'restrict/error'
require 'restrict/login_required'
require 'restrict/access_denied'
require 'restrict/restriction'
require 'restrict/gatekeeper'
require 'restrict/rails/controller'
require 'restrict/rails/railtie' if defined?(Rails)

module Restrict

  def self.config(&block)
    @configuration ||= Restrict::Configuration.new
    block_given? ? yield(@configuration) : @configuration
  end

end
