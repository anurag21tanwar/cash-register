# frozen_string_literal: true

require 'rails_helper'
RSpec.describe BasketSerializer, type: :serializer do
  let(:basket) do
    basket = create(:basket)
    product = create(:product, :gt)
    basket.items << create(:item, product: product, basket: basket, quantity: 1)
    basket
  end

  subject { described_class.new(basket).as_json }

  it 'have items' do
    expect(subject[:items]).to eq(basket.items.map { |i| ItemSerializer.new(i).as_json })
  end
end
