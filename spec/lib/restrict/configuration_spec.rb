require 'spec_helper'

describe Restrict::Configuration do
  let(:configuration) { Restrict::Configuration.new }

  describe '#authentication_method' do
    it 'has a sensible default' do
      expect(configuration.authentication_validation_method).to eq :user_signed_in?
    end

    it 'can be overridden' do
      configuration.authentication_validation_method = :foobar?
      expect(configuration.authentication_validation_method).to eq :foobar?
    end
  end

end
