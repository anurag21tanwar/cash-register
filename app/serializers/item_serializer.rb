# frozen_string_literal: true

class ItemSerializer < ActiveModel::Serializer
  attributes :id, :code, :quantity, :amount

  def code
    object.product.code
  end
end
