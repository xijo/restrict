module Restrict
  class Configuration
    attr_writer :authentication_validation_method

    def authentication_validation_method
      @authentication_validation_method || :user_signed_in?
    end
  end
end
