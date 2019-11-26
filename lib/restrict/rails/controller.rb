module Restrict
  module Rails
    module Controller
      extend ActiveSupport::Concern

      def restrictions
        inherited_restrictions + self.class.__send__(:restrict_restrictions)
      end

      def inherited_restrictions
        self.class.ancestors.map do |ancestor|
          if ancestor.instance_variable_get(:@restrict_gatekeeper_installed)
            ancestor.__send__(:restrict_restrictions)
          end
        end.compact.flatten
      end

      module ClassMethods
        def restrict(*args)
          install_gatekeeper
          restrict_restrictions << Restrict::Restriction.new(*args)
        end

        # Access the class instance variable. Do not mistake this method with
        # the instance method `#restrictions` which is actually used to determine
        # access and that respects inherited restrictions.
        # Hence the `__` name.
        private def restrict_restrictions
          @restrictions ||= []
        end

        def inherited(subclass)
          subclass.include Restrict::Rails::Controller
        end

        # This could happen in included block as well, but often you need
        # other before filters to happen before you actually check the
        # restrictions, so lets set it where it is used in the code as well.
        def install_gatekeeper
          return if @restrict_gatekeeper_installed
          before_action :invoke_gatekeeper
          @restrict_gatekeeper_installed = true
        end
      end

      private

      def invoke_gatekeeper
        Restrict::Gatekeeper.new.eye(self)
      end
    end
  end
end
