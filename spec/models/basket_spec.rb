# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Basket, type: :model do
  subject { create(:basket) }

  it { is_expected.to be_valid }

  describe 'associations' do
    it { should have_many(:products).through(:items) }
    it { should have_many(:items) }
  end
end
