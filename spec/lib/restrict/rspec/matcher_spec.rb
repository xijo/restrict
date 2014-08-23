require 'spec_helper'

describe 'have_restriction_on' do
  let(:controller) { ExampleController.new }

  # before do
  #   controller.class.restrict :index
  #   controller.class.restrict :show, allow_if: :access_allowed?
  # end


  context 'without restrictions' do
    it 'matcher fails' do
      expect {
        expect(controller).to have_restriction_on(:show)
      }.to raise_error RSpec::Expectations::ExpectationNotMetError
    end

    it 'negated matcher passes' do
      expect(controller).not_to have_restriction_on(:show)
    end
  end

  context 'with plain restriction' do
    before { controller.class.restrict :show }

    it 'matcher passes' do
      expect(controller).to have_restriction_on(:show)
    end

    it 'wrong matcher fails' do
      expect {
        expect(controller).to have_restriction_on(:index)
      }.to raise_error RSpec::Expectations::ExpectationNotMetError
    end

    it 'negated matcher fails' do
      expect {
        expect(controller).not_to have_restriction_on(:show)
      }.to raise_error RSpec::Expectations::ExpectationNotMetError
    end

    it 'matcher conditional chain fails' do
      expect {
        expect(controller).to have_restriction_on(:show).with_allow_if(:something)
      }.to raise_error RSpec::Expectations::ExpectationNotMetError
    end

    it 'negated matcher with conditional chain passes' do
      expect(controller).not_to have_restriction_on(:show).with_allow_if(:something)
    end
  end

  context 'with conditional restriction' do
    before { controller.class.restrict :show, allow_if: :something }

    it 'matcher passes' do
      expect(controller).to have_restriction_on(:show)
    end

    it 'wrong matcher fails' do
      expect {
        expect(controller).to have_restriction_on(:index)
      }.to raise_error RSpec::Expectations::ExpectationNotMetError
    end

    it 'negated matcher fails' do
      expect {
        expect(controller).not_to have_restriction_on(:show)
      }.to raise_error RSpec::Expectations::ExpectationNotMetError
    end

    it 'matcher conditional chain passes' do
      expect(controller).to have_restriction_on(:show).with_allow_if(:something)
    end

    it 'negated matcher with conditional chain passes' do
      expect {
        expect(controller).not_to have_restriction_on(:show).with_allow_if(:something)
      }.to raise_error RSpec::Expectations::ExpectationNotMetError
    end
  end

end
