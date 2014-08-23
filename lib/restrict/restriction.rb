module Restrict
  class Restriction
    attr_accessor :actions, :allow_if

    def initialize(*args)
      options   = args.extract_options!
      @allow_if = options[:allow_if]
      @actions  = args
      actions.empty? and raise ArgumentError, "expected actions to restrict, but got #{actions.inspect}"
    end

    def concerning?(action)
      concerns_action?(action) || concerns_all?
    end

    private

    def concerns_all?
      actions.include?(:all_actions)
    end

    def concerns_action?(name)
      actions.include?(name.to_sym)
    end
  end
end
