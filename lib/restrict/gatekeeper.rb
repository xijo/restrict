module Restrict
  class Gatekeeper
    def eye(controller)
      Array(concerning_restrictions(controller)).each do |restriction|
        handle_restriction(restriction, controller)
      end
    end

    private

    def handle_restriction(restriction, controller)
      controller.current_user or raise Restrict::LoginRequired

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
