require_relative '../spec_helper'

describe Series do
  let(:publisher) { Publisher.create(name: 'Some Fun Publisher') }
  let(:series) { Series.new(name: 'Acme Action Hero', publisher_id: publisher.id) }

  it 'is valid' do
    expect(series).to be_valid
  end

  describe '#name' do
    it 'is invalid when empty' do
      series.name = ''
      expect(series).to_not be_valid
    end
  end

  describe '#publisher_id' do
    it 'is invalid when empty' do
      series.publisher_id = ''
      expect(series).to_not be_valid
    end
  end
end
