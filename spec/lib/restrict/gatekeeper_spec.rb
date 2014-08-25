require 'spec_helper'

describe Restrict::Gatekeeper do

  let(:gatekeeper) { Restrict::Gatekeeper.new }
  let(:controller) { ExampleController.new }

  before { controller.action_name = 'edit' }

  describe '#eye' do
    context 'without restriction' do
      it 'grants anonymous access' do
        expect { gatekeeper.eye(controller) }.not_to raise_error
      end

      it 'grants user access' do
        controller.user_signed_in = true
        expect { gatekeeper.eye(controller) }.not_to raise_error
      end
    end

    context 'with plain restriction' do
      before { controller.class.restrict :edit }

      it 'denies anonymous access' do
        expect { gatekeeper.eye(controller) }.to raise_error(Restrict::LoginRequired)
      end

      it 'grants user access' do
        controller.user_signed_in = true
        expect { gatekeeper.eye(controller) }.not_to raise_error
      end
    end

    context 'with conditional restriction' do
      before do
        controller.class.restrict :action1, unless: :missing
        controller.class.restrict :action2, unless: :falsy
        controller.class.restrict :action3, unless: :truthy
      end

      it 'raises on missing method' do
        controller.user_signed_in = true
        controller.action_name = 'action1'
        expect { gatekeeper.eye(controller) }.to raise_error(NoMethodError)
      end

      it 'denies anonymous access' do
        controller.action_name = 'action1'
        expect { gatekeeper.eye(controller) }.to raise_error(Restrict::LoginRequired)
      end

      it 'denies access on falsy return value' do
        controller.user_signed_in = true
        controller.action_name = 'action2'
        expect { gatekeeper.eye(controller) }.to raise_error(Restrict::AccessDenied)
      end

      it 'grants access on truthy return value' do
        controller.user_signed_in = true
        controller.action_name = 'action3'
        expect { gatekeeper.eye(controller) }.not_to raise_error
      end
    end

    context 'with multiple restrictions' do
      before do
        controller.class.restrict :all_actions
        controller.class.restrict :edit, unless: :falsy
      end

      it 'denies access if any restriction fails' do
        controller.user_signed_in = true
        expect { gatekeeper.eye(controller) }.to raise_error(Restrict::AccessDenied)
      end
    end
  end
end
