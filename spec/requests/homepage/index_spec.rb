# frozen_string_literal: true

require 'rails_helper'
RSpec.describe '/', type: :request do
  it 'successful' do
    get root_path
    expect(response).to be_successful
  end

  it 'response body' do
    get root_path
    expect(response.body).to include('<title>Cash Register HW</title>')
  end
end
