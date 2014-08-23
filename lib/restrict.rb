require 'active_support'

require 'restrict/version'
require 'restrict/error'
require 'restrict/login_required'
require 'restrict/access_denied'
require 'restrict/restriction'
require 'restrict/gatekeeper'
require 'restrict/rails/controller'
require 'restrict/rails/railtie' if defined?(Rails)

module Restrict
  # Your code goes here...
end
