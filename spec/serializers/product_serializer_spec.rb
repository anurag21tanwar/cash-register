# frozen_string_literal: true

require 'rails_helper'
RSpec.describe ProductSerializer, type: :serializer do
  let(:product) { create(:product, :gt) }

  subject { described_class.new(product).as_json }

  it 'has a id' do
    expect(subject[:id]).to eq(product.id)
  end

  it 'has code' do
    expect(subject[:code]).to eq(product.code)
  end

  it 'has name' do
    expect(subject[:name]).to eq(product.name)
  end

  it 'has price' do
    expect(subject[:price]).to eq(product.price)
  end
end
