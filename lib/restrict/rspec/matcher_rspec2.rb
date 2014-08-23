RSpec::Matchers.define :have_restriction_on do |given_action_name|
  match do |given_controller|
    @given_action_name = given_action_name
    @given_controller = given_controller

    @restriction = given_controller.restrictions.find do |restriction|
      restriction.concerning?(given_action_name)
    end

    if @restriction
      if @given_allow_if
        @restriction.allow_if == @given_allow_if
      else
        true
      end
    else
      false
    end
  end

  chain :with_allow_if do |given_allow_if|
    @given_allow_if = given_allow_if
  end

  failure_message_for_should do |actual|
    if @restriction && @given_allow_if
      "Expected restriction to call #{@given_allow_if.inspect}, but calls #{@restriction.allow_if.inspect}"
    else
      "Expected to have restriction on #{@given_action_name}, but was not found in #{@given_controller.restrictions.inspect}"
    end
  end

  failure_message_for_should_not do |actual|
    if @given_allow_if
      "Expected restriction not to call #{@given_allow_if.inspect}, but calls #{@restriction.allow_if.inspect}"
    else
      "Expected not to have restriction on #{@given_action_name}, but was found in #{@given_controller.restrictions.inspect}"
    end
  end

  def description
    "Checks if a restriction for a given action is defined on the controller"
  end
end
