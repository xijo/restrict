module Restrict
  class Restriction
    attr_accessor :actions, :options, :unless, :on

    def initialize(*args)
      @options  = args.extract_options!
      @unless   = @options[:unless]
      @on       = @options[:on]
      @actions  = args
    end

    def applies_to?(action)
      applies_to_action?(action) || applies_to_all_actions?
    end

    def validate(controller)
      options.has_key?(:unless) or return

      if options.has_key?(:on)
        object = controller.__send__(on) or raise Restrict::AccessDenied, reason: 'object given was #{object.inspect}'

        unless controller.__send__(@unless, object)
          raise Restrict::AccessDenied, reason: self
        end
      else
        unless controller.__send__(@unless)
          raise Restrict::AccessDenied, reason: self
        end
      end
    end

    private

    def applies_to_all_actions?
      actions.empty?
    end

    def applies_to_action?(name)
      actions.include?(name.to_sym)
    end
  end
end
