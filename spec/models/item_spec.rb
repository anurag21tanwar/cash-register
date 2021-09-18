# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Item, type: :model do
  let(:basket) { create(:basket) }
  let(:product) { create(:product, :gt) }
  let(:quantity) { 1 }
  subject { create(:item, product: product, basket: basket, quantity: quantity) }

  it { is_expected.to be_valid }

  describe 'associations' do
    it { should belong_to(:product) }
    it { should belong_to(:basket) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_numericality_of(:quantity).is_greater_than(0) }
  end

  describe 'amount' do
    context 'when items code is GR1' do
      let(:product) { create(:product, :gt) }

      context 'quantity is 2' do
        let(:quantity) { 2 }

        it 'discount should be 1+1' do
          expect(subject.amount).to eq(3.11)
        end
      end

      context 'quantity is 1' do
        let(:quantity) { 1 }

        it 'discount should not be 1+1' do
          expect(subject.amount).to eq(3.11)
        end
      end
    end

    context 'when items code is CF1' do
      let(:product) { create(:product, :cf) }

      context 'quantity is > 3' do
        let(:quantity) { 3 }

        it 'discount should be 2/3rd of the total items price' do
          expect(subject.amount).to eq(22.46)
        end
      end

      context 'quantity is < 3' do
        let(:quantity) { 2 }

        it 'discount should not be applicable' do
          expect(subject.amount).to eq(22.46)
        end
      end
    end

    context 'when items code is SR1' do
      let(:product) { create(:product, :sr) }

      context 'quantity is >= 3' do
        let(:quantity) { 3 }

        it 'discount should be price - 0.5€ of the each items price' do
          expect(subject.amount).to eq(13.50)
        end
      end

      context 'quantity is < 3' do
        let(:quantity) { 2 }

        it 'discount should not be applicable' do
          expect(subject.amount).to eq(10.00)
        end
      end
    end
  end
end
