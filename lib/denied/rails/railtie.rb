module Denied
  module Rails
    class Railtie < ::Rails::Railtie
      initializer 'denied.add_controller_extension' do
        ActionController::Base.send :include, Denied::Rails::Controller
      end
    end
  end
end
