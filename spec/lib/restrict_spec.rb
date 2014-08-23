require 'spec_helper'

describe Restrict do

  describe '#config' do
    it 'returns a configuration' do
      expect(Restrict.config).to be_a Restrict::Configuration
    end

    it 'yiels a configuration if block given' do
      Restrict.config do |config|
        expect(config).to be_a Restrict::Configuration
      end
    end

    it 'keeps the same configuration' do
      expect(Restrict.config).to eq Restrict.config
    end
  end

end
