require 'spec_helper'

describe Restrict::Restriction do
  let(:restriction) { Restrict::Restriction.new(:show, :edit, role: :manager) }

  describe '#initialize' do
    it 'knows about its actions' do
      expect(restriction.actions).to eq [:show, :edit]
    end

    it 'raises an error if no actions were given' do
      expect { Restrict::Restriction.new }.to raise_error(ArgumentError)
    end
  end

  describe '#restricts?' do
    it 'returns true if the given action is contained' do
      expect(restriction).to be_restricts(:show)
    end

    it 'returns false if the given action name is not contained' do
      expect(restriction).not_to be_restricts(:index)
    end
  end

  describe '#role' do
    it 'returns the role name if given' do
      expect(restriction.role).to eq :manager
    end

    it 'returns nil if non was given' do
      expect(Restrict::Restriction.new(:foo).role).to be_nil
    end
  end

end
