module Denied
  class Gatekeeper
    def eye(controller)
      restriction = current_restriction(controller)
      restriction and handle_restriction(restriction, controller)
    end

    private

    def handle_restriction(restriction, controller)
      controller.current_user or raise Denied::LoginRequired

      if restriction.allow_if
        unless controller.__send__(restriction.allow_if)
          raise Denied::AccessDenied, reason: restriction
        end
      end
    end

    def current_restriction(controller)
      controller.restrictions or return
      controller.restrictions.find do |restriction|
        restriction.restricts?(controller.action_name)
      end
    end
  end
end
