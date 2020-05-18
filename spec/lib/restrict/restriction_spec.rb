require 'spec_helper'

describe Restrict::Restriction do
  let(:restriction) { Restrict::Restriction.new(:show, :edit) }

  describe '#initialize' do
    it 'knows about its actions' do
      expect(restriction.actions).to eq [:show, :edit]
    end
  end

  describe '#applies_to?' do
    it 'returns true if the given action is contained' do
      expect(restriction).to be_applies_to(:show)
    end

    it 'returns true if the given name is a string' do
      expect(restriction).to be_applies_to('show')
    end

    it 'returns false if the given action name is not contained' do
      expect(restriction).not_to be_applies_to(:index)
    end

    it 'returns true if it concerns all actions' do
      restriction = Restrict::Restriction.new
      expect(restriction).to be_applies_to(:foo)
      expect(restriction).to be_applies_to(:bar)
    end
  end

  describe '#validate' do
    describe 'with :on option' do
      let(:controller) { ObjectController.new }

      it 'does not raise if no condition was given' do
        restriction = Restrict::Restriction.new on: :managed_object
        expect { restriction.validate(controller) }.not_to raise_error
      end

      it 'does not raise an error if `on` and `unless` match' do
        restriction = Restrict::Restriction.new on: :managed_object, unless: :manager_of?
        expect { restriction.validate(controller) }.not_to raise_error
      end

      it 'raises an error if `unless` does not work on `on`' do
        restriction = Restrict::Restriction.new on: :rougue_object, unless: :manager_of?
        expect { restriction.validate(controller) }.to raise_error(Restrict::AccessDenied)
      end

      it 'raises an error if `on` is nil' do
        restriction = Restrict::Restriction.new on: :nil_object, unless: :manager_of?
        expect { restriction.validate(controller) }.to raise_error(Restrict::AccessDenied)
      end

      it 'works with aliases' do
        restriction = Restrict::Restriction.new of: :managed_object, unless: :manager_of?
        expect { restriction.validate(controller) }.not_to raise_error

        restriction = Restrict::Restriction.new object: :managed_object, unless: :manager_of?
        expect { restriction.validate(controller) }.not_to raise_error
      end
    end

    describe 'without :on option' do
      let(:controller) { ExampleController.new }

      it 'does not raise an error if `unless` works' do
        restriction = Restrict::Restriction.new unless: :truthy
        expect { restriction.validate(controller) }.not_to raise_error
      end

      it 'raises an error if `unless` does not work' do
      restriction = Restrict::Restriction.new unless: :falsy
        expect { restriction.validate(controller) }.to raise_error(Restrict::AccessDenied)
      end
    end
  end
end
