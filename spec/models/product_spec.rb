# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Product, type: :model do
  subject { create(:product, :gt) }

  it { is_expected.to be_valid }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:code) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:price) }
  end
end
