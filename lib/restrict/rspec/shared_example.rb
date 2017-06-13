RSpec.shared_examples "restricts access to" do |action_name, unless_condition|
  it "restricts #{action_name}#{unless_condition && " unless #{unless_condition}"}" do
    expect(controller).to have_restriction_on(action_name).unless(unless_condition)
  end
end
