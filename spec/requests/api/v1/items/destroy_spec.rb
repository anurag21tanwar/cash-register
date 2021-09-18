# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'api/v1/item/:id', type: :request do
  let(:basket) { create(:basket) }
  let(:product) { create(:product, :gt) }
  let(:item) { create(:item, product: product, basket: basket) }

  it 'successful' do
    delete api_v1_item_path(item)
    expect(response).to be_successful
  end

  it 'response body' do
    delete api_v1_item_path(item)
    expected = ItemSerializer.new(item).as_json.to_json
    expect(response.body).to eq(expected)
  end

  it 'should destroy from db' do
    delete api_v1_item_path(item)
    expect { Item.find(item.id) }.to raise_exception { ActiveRecord::RecordNotFound }
  end
end
