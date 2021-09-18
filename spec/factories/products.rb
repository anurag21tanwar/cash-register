# frozen_string_literal: true

FactoryBot.define do
  factory :product, class: 'Product' do
    trait :gt do
      code { 'GR1' }
      name { 'Green Tea' }
      price { 3.11 }
    end

    trait :cf do
      code { 'CF1' }
      name { 'Coffee' }
      price { 11.23 }
    end

    trait :sr do
      code { 'SR1' }
      name { 'Strawberries' }
      price { 5.0 }
    end
  end
end
