# frozen_string_literal: true

class Product < ApplicationRecord
  default_scope { order(:name) }

  validates :code, :name, :price, presence: true
end
