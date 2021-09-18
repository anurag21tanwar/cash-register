# frozen_string_literal: true

class Item < ApplicationRecord
  default_scope { includes(:product) }

  belongs_to :product
  belongs_to :basket

  validates :product_id, :basket_id, :quantity, presence: true
  validates :quantity, numericality: { greater_than: 0 }

  def amount
    format_amount(apply_discount(product.code))
  end

  private

  def apply_discount(code)
    {
      'GR1' => for_gr1,
      'SR1' => for_sr1,
      'CF1' => for_cf1
    }.fetch(code, product.price * quantity)
  end

  def for_gr1
    if quantity.even?
      (quantity / 2) * formatted_price
    else
      ((quantity / 2) * formatted_price) + formatted_price
    end
  end

  def for_sr1
    if quantity > 2
      (formatted_price - (BigDecimal(1, 0) / BigDecimal(2, 0))) * quantity
    else
      formatted_price * quantity
    end
  end

  def for_cf1
    if quantity > 2
      (formatted_price * quantity) * (BigDecimal(2, 0) / BigDecimal(3, 0))
    else
      (formatted_price * quantity)
    end
  end

  def formatted_price
    BigDecimal(product.price, 0)
  end

  def format_amount(amount)
    BigDecimal(amount, 0).truncate(2)
  end
end
