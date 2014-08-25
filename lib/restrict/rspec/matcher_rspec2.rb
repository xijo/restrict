RSpec::Matchers.define :have_restriction_on do |given_action_name|
  match do |given_controller|
    @given_action_name = given_action_name
    @given_controller = given_controller

    @restriction = given_controller.restrictions.find do |restriction|
      restriction.applies_to?(given_action_name)
    end

    if @restriction
      if @given_unless
        @restriction.unless == @given_unless
      else
        true
      end
    else
      false
    end
  end

  chain :unless do |given_unless|
    @given_unless = given_unless
  end

  failure_message_for_should do |actual|
    if @restriction && @given_unless
      "Expected restriction to call #{@given_unless.inspect}, but calls #{@restriction.unless.inspect}"
    else
      "Expected to have restriction on #{@given_action_name}, but was not found in #{@given_controller.restrictions.inspect}"
    end
  end

  failure_message_for_should_not do |actual|
    if @given_unless
      "Expected restriction not to call #{@given_unless.inspect}, but calls #{@restriction.unless.inspect}"
    else
      "Expected not to have restriction on #{@given_action_name}, but was found in #{@given_controller.restrictions.inspect}"
    end
  end

  def description
    "Checks if a restriction for a given action is defined on the controller"
  end
end
