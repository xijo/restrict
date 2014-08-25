require 'spec_helper'

describe Restrict::Restriction do
  let(:restriction) { Restrict::Restriction.new(:show, :edit) }

  describe '#initialize' do
    it 'knows about its actions' do
      expect(restriction.actions).to eq [:show, :edit]
    end

    it 'raises an error if no actions were given' do
      expect { Restrict::Restriction.new }.to raise_error(ArgumentError)
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

    it 'returns true if it concerns :all_actions' do
      restriction = Restrict::Restriction.new(:all_actions)
      expect(restriction).to be_applies_to(:foo)
      expect(restriction).to be_applies_to(:bar)
    end
  end
end
