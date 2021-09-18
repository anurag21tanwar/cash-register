# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'api/v1/items', type: :request do
  let(:basket) { create(:basket) }
  let(:product) { create(:product, :gt) }

  before do
    allow_any_instance_of(ActionDispatch::Request).to receive(:session) { { basket_id: basket.id } }
  end

  it 'successful' do
    post api_v1_items_path(product_id: product.id)
    expect(response).to be_successful
  end

  describe 'response body' do
    context 'when first time adding to basket' do
      it 'should add a new item to cart' do
        post api_v1_items_path(product_id: product.id)
        expected = ItemSerializer.new(Item.find_by(product: product, basket: basket)).as_json.to_json
        expect(response.body).to eq(expected)
      end
    end

    context 'when first time adding to basket' do
      let(:item) { create(:item, basket: basket, product: product) }

      before do
        basket.items << item
      end

      it 'should only increase item quantity' do
        post api_v1_items_path(product_id: product.id)
        expected = {
          id: item.id,
          code: item.product.code,
          quantity: item.quantity + 1,
          amount: item.amount
        }.to_json
        expect(response.body).to eq(expected)
      end
    end
  end
end
