# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'api/v1/products', type: :request do
  it 'successful' do
    get api_v1_products_path
    expect(response).to be_successful
  end

  it 'response body' do
    create(:product, :cf)
    get api_v1_products_path
    expected = Product.all.map { |p| ProductSerializer.new(p) }.to_json
    expect(response.body).to eq(expected)
  end
end
