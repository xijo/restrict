module Restrict
  module Rails
    module Controller
      extend ActiveSupport::Concern

      included do
        cattr_accessor :restrictions
        self.restrictions ||= []
        before_filter :invoke_gatekeeper
      end

      module ClassMethods
        def restrict(*args)
          self.restrictions ||= []
          restrictions << Restrict::Restriction.new(*args)
        end
      end

      private

      def invoke_gatekeeper
        Restrict::Gatekeeper.new.eye(self)
      end
    end
  end
end
