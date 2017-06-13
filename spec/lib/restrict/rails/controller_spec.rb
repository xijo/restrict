require 'spec_helper'

describe Restrict::Rails::Controller do

  let(:controller) { ExampleController.new }

  before do
    controller.class.restrict :index
    controller.class.restrict :show, unless: :access_allowed?
  end

  describe '#restrict' do
    it 'builds and adds a plain restriction' do
      expect(controller).to have_restriction_on(:index)
    end

    it 'builds and adds a conditional restriction' do
      expect(controller).to have_restriction_on(:show).unless(:access_allowed?)
    end

    include_examples 'restricts access to', :show, :access_allowed?
  end

  describe '#included' do
    it 'adds the before filter' do
      expect(controller.before_filters).to include :invoke_gatekeeper
    end
  end

  describe '#invoke_gatekeeper' do
    it 'builds and calls a gatekeeper for the controller' do
      expect_any_instance_of(Restrict::Gatekeeper).to receive(:eye).with(controller)
      controller.__send__ :invoke_gatekeeper
    end
  end

end
