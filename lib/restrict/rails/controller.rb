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

        def install_gatekeeper
          return if @gatekeeper_installed
          before_filter :invoke_gatekeeper
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
