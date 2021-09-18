# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'api/v1/basket/:id', type: :request do
  let(:basket) do
    basket = create(:basket)
    product = create(:product, :gt)
    basket.items << create(:item, product: product, basket: basket, quantity: 1)
    basket
  end

  before do
    allow_any_instance_of(ActionDispatch::Request).to receive(:session) { { basket_id: basket.id } }
  end

  it 'successful' do
    get api_v1_basket_path(basket)
    expect(response).to be_successful
  end

  it 'response body' do
    get api_v1_basket_path(basket)
    expected = BasketSerializer.new(basket).as_json.to_json
    expect(response.body).to eq(expected)
  end
end
