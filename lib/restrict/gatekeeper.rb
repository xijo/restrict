module Restrict
  class Gatekeeper
    def eye(controller)
      Array(concerning_restrictions(controller)).each do |restriction|
        handle_restriction(restriction, controller)
      end
    end

    private

    def validate_signed_in(controller)
      method = Restrict.config.authentication_validation_method
      controller.__send__(method) or raise Restrict::LoginRequired
    end

    def handle_restriction(restriction, controller)
      validate_signed_in(controller)

      if restriction.allow_if
        unless controller.__send__(restriction.allow_if)
          raise Restrict::AccessDenied, reason: restriction
        end
      end
    end

    def concerning_restrictions(controller)
      controller.restrictions or return
      controller.restrictions.select do |restriction|
        restriction.concerning?(controller.action_name)
      end
    end
  end
end
