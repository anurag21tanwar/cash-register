# frozen_string_literal: true

class BasketSerializer < ActiveModel::Serializer
  has_many :items, serializer: ItemSerializer
end
