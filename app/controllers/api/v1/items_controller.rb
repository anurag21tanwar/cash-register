# frozen_string_literal: true

module Api
  module V1
    class ItemsController < ApplicationController
      def create
        product = Product.find_by(id: params[:product_id])
        current_basket = @current_basket

        if current_basket.products.include? product
          @item = current_basket.items.find_by(product_id: product.id)
          @item.quantity += 1
        else
          @item = Item.create(basket: current_basket, product: product)
        end

        if @item.save
          render status: :ok, json: current_basket.items.map { |item| ItemSerializer.new(item).as_json }
        else
          render status: :unprocessable_entity, json: {}
        end
      end
    end
  end
end
