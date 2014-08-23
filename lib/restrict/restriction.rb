module Restrict
  class Restriction
    attr_accessor :actions, :role, :allow_if

    def initialize(*args)
      options   = args.extract_options!
      @role     = options[:role]
      @allow_if = options[:allow_if]
      @actions  = args
      actions.empty? and raise ArgumentError, "expected actions to restrict, but got #{actions.inspect}"
    end

    def restricts?(action_name)
      actions.include?(action_name.to_sym)
    end
  end
end
