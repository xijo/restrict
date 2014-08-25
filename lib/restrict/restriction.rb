module Restrict
  class Restriction
    attr_accessor :actions, :unless

    def initialize(*args)
      options   = args.extract_options!
      @unless = options[:unless]
      @actions  = args
      actions.empty? and raise ArgumentError, "expected actions to restrict, but got #{actions.inspect}"
    end

    def applies_to?(action)
      applies_to_action?(action) || applies_to_all_actions?
    end

    private

    def applies_to_all_actions?
      actions.include?(:all_actions)
    end

    def applies_to_action?(name)
      actions.include?(name.to_sym)
    end
  end
end
