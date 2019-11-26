RSpec::Matchers.define :have_restriction_on do |given_action_name|
  match do |given_controller|
    @given_action_name = given_action_name
    @given_controller = given_controller

    @restriction = given_controller.restrictions.find do |restriction|
      if restriction.applies_to?(given_action_name) && matching_unless(restriction, @given_unless)
        restriction
      end
    end

    !!@restriction
  end

  chain :unless do |given_unless|
    @given_unless = given_unless
  end

  def matching_unless(restriction, given_unless)
    given_unless or return true
    restriction.unless == given_unless
  end

  failure_message do |actual|
    if @restriction && @given_unless
      "Expected restriction to call #{@given_unless.inspect}, but calls #{@restriction.unless.inspect}"
    else
      "Expected to have restriction on #{@given_action_name}, but was not found in #{@given_controller.restrictions.inspect}"
    end
  end

  failure_message_when_negated do |actual|
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
