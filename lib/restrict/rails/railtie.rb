module Restrict
  module Rails
    class Railtie < ::Rails::Railtie
      initializer 'restrict.add_controller_extension' do
        ActionController::Base.send :include, Restrict::Rails::Controller
      end
    end
  end
end
