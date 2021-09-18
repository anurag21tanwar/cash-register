# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'api/v1/item/:id/add', type: :request do
  let(:basket) { create(:basket) }
  let(:product) { create(:product, :gt) }
  let(:item) { create(:item, product: product, basket: basket) }

  it 'successful' do
    put add_api_v1_item_path(item)
    expect(response).to be_successful
  end

  it 'response body' do
    put add_api_v1_item_path(item)
    expected = {
      id: item.id,
      code: item.product.code,
      quantity: item.quantity + 1,
      amount: item.amount
    }.to_json
    expect(response.body).to eq(expected)
  end
end
