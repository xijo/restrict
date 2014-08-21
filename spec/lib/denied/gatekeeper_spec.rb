require 'spec_helper'

describe Denied::Gatekeeper do

  let(:gatekeeper) { Denied::Gatekeeper.new }
  let(:controller) { ExampleController.new }
  let(:user)       { FakeUser.new }

  before { controller.action_name = 'edit' }

  describe '#eye' do
    context 'without restriction' do
      it 'grants anonymous access' do
        expect { gatekeeper.eye(controller) }.not_to raise_error
      end

      it 'grants user access' do
        controller.current_user = user
        expect { gatekeeper.eye(controller) }.not_to raise_error
      end
    end

    context 'with plain restriction' do
      before { controller.class.restrict :edit }

      it 'denies anonymous access' do
        expect { gatekeeper.eye(controller) }.to raise_error(Denied::LoginRequired)
      end

      it 'grants user access' do
        controller.current_user = user
        expect { gatekeeper.eye(controller) }.not_to raise_error
      end
    end

    context 'with conditional restriction' do
      before do
        controller.class.restrict :action1, allow_if: :missing
        controller.class.restrict :action2, allow_if: :falsy
        controller.class.restrict :action3, allow_if: :truthy
      end

      it 'raises on missing method' do
        controller.current_user = user
        controller.action_name = 'action1'
        expect { gatekeeper.eye(controller) }.to raise_error(NoMethodError)
      end

      it 'denies anonymous access' do
        controller.action_name = 'action1'
        expect { gatekeeper.eye(controller) }.to raise_error(Denied::LoginRequired)
      end

      it 'denies access on falsy return value' do
        controller.current_user = user
        controller.action_name = 'action2'
        expect { gatekeeper.eye(controller) }.to raise_error(Denied::AccessDenied)
      end

      it 'grants access on truthy return value' do
        controller.current_user = user
        controller.action_name = 'action3'
        expect { gatekeeper.eye(controller) }.not_to raise_error
      end
    end
  end
end
