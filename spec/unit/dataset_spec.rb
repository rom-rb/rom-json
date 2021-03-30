# frozen_string_literal: true

require 'rom/lint/spec'

describe ROM::JSON::Dataset do
  let(:data) { [{ id: 1 }, { id: 2 }] }
  let(:dataset) { ROM::JSON::Dataset.new(data) }

  it_behaves_like 'a rom enumerable dataset'

  it 'symbolizes keys' do
    dataset = ROM::JSON::Dataset.new(['foo' => 23])
    expect(dataset.to_a).to eq([{ foo: 23 }])
  end

  it 'symbolizes keys recursively' do
    dataset = ROM::JSON::Dataset.new(['foo' => { 'bar' => :baz }])
    expect(dataset.to_a).to eq([foo: { bar: :baz }])
  end
end
