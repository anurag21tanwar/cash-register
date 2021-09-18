# frozen_string_literal: true

require 'rails_helper'
RSpec.describe ItemSerializer, type: :serializer do
  let(:basket) { create(:basket) }
  let(:product) { create(:product, :gt) }
  let(:item) { create(:item, product: product, basket: basket, quantity: 1) }

  subject { described_class.new(item).as_json }

  it 'has a id' do
    expect(subject[:id]).to eq(item.id)
  end

  it 'has code' do
    expect(subject[:code]).to eq(item.product.code)
  end

  it 'has quantity' do
    expect(subject[:quantity]).to eq(item.quantity)
  end

  it 'has amount' do
    expect(subject[:amount]).to eq(item.amount)
  end
end
