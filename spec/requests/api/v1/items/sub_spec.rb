# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'api/v1/item/:id/sub', type: :request do
  let(:basket) { create(:basket) }
  let(:product) { create(:product, :gt) }
  let(:quantity) { 1 }
  let(:item) { create(:item, product: product, basket: basket, quantity: quantity) }

  it 'successful' do
    put sub_api_v1_item_path(item)
    expect(response).to be_successful
  end

  describe 'response body' do
    context 'when quantity > 1' do
      let(:quantity) { 2 }

      it 'should decrease quantity' do
        put sub_api_v1_item_path(item)
        expected = {
          id: item.id,
          code: item.product.code,
          quantity: item.quantity - 1,
          amount: item.amount
        }.to_json
        expect(response.body).to eq(expected)
      end
    end

    context 'when quantity = 1' do
      it 'should not decrease quantity' do
        put sub_api_v1_item_path(item)
        expected = {
          id: item.id,
          code: item.product.code,
          quantity: 1,
          amount: item.amount
        }.to_json
        expect(response.body).to eq(expected)
      end
    end
  end
end
