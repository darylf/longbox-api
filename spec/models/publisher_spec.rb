require_relative '../spec_helper'

describe Publisher do
  let(:publisher) { Publisher.new(name: 'Acme Publishing') }

  it 'is valid' do
    expect(publisher).to be_valid
  end

  describe '#name' do
    it 'is invalid when empty' do
      publisher.name = ''
      expect(publisher).to_not be_valid
    end
  end
end
