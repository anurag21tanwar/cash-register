# frozen_string_literal: true

module Api
  module V1
    class ItemsController < ApplicationController
      before_action :item, only: %i[destroy add sub]

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
          render status: :ok, json: ItemSerializer.new(@item).as_json
        else
          render status: :unprocessable_entity, json: {}
        end
      end

      def destroy
        @item.destroy
        render status: :ok, json: ItemSerializer.new(@item).as_json
      end

      def add
        @item.quantity += 1
        @item.save
        render status: :ok, json: ItemSerializer.new(@item).as_json
      end

      def sub
        if @item.quantity > 1
          @item.quantity -= 1
          @item.save
        end
        render status: :ok, json: ItemSerializer.new(@item).as_json
      end

      private

      def item
        @item = Item.find_by(id: params[:id])
      end
    end
  end
end
