module Restrict
  class Gatekeeper
    def eye(controller)
      restriction = current_restriction(controller)
      restriction and handle_restriction(restriction, controller)
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

    def current_restriction(controller)
      controller.restrictions or return
      controller.restrictions.find do |restriction|
        restriction.concerning?(controller.action_name)
      end
    end
  end
end
