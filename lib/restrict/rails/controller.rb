module Restrict
  module Rails
    module Controller
      extend ActiveSupport::Concern

      included do
        class_attribute :restrictions
      end

      module ClassMethods
        def restrict(*args)
          install_gatekeeper
          self.restrictions ||= []
          restrictions << Restrict::Restriction.new(*args)
        end

        # This could happen in included block as well, but often you need
        # other before filters to happen before you actually check the
        # restrictions, so lets set it where it is used in the code as well.
        def install_gatekeeper
          return if @gatekeeper_installed
          before_action :invoke_gatekeeper
          @gatekeeper_installed = true
        end
      end

      private

      def invoke_gatekeeper
        Restrict::Gatekeeper.new.eye(self)
      end
    end
  end
end
