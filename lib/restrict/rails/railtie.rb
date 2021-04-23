module Restrict
  module Rails
    class Railtie < ::Rails::Railtie
      initializer 'restrict.add_controller_extension' do
        ActiveSupport.on_load(:action_controller_base) do
          ActionController::Base.include Restrict::Rails::Controller
        end
      end
    end
  end
end
