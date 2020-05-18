module Restrict
  class Restriction
    attr_accessor :actions, :options, :unless, :on

    def initialize(*args)
      @options  = args.extract_options!
      @unless   = @options[:unless]
      @on       = @options[:on] || options[:of] || options[:object]
      @actions  = args
    end

    def applies_to?(action)
      applies_to_action?(action) || applies_to_all_actions?
    end

    def validate(controller)
      @unless or return

      unless_args = []
      if @on
        object = controller.__send__(on)
        unless_args << object or raise Restrict::AccessDenied, reason: 'object given was #{object.inspect}'
      end

      unless controller.__send__(@unless, *unless_args)
        raise Restrict::AccessDenied, reason: self
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
