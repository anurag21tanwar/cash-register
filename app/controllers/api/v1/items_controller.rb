# frozen_string_literal: true

module Api
  module V1
    class ItemsController < ApplicationController
      before_action :product, only: :create
      before_action :item, only: %i[destroy add sub]

      def create
        find_or_create_item
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

      def product
        @product = Product.find_by(id: params[:product_id])
      end

      def find_or_create_item
        if @current_basket.products.include? product
          @item = @current_basket.items.find_by(product: @product)
          @item.quantity += 1
        else
          @item = Item.create(basket: @current_basket, product: @product)
        end
      end
    end
  end
end
