# frozen_string_literal: true

class Basket < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :products, through: :items
end
