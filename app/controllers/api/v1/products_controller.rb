# frozen_string_literal: true

module Api
  module V1
    class ProductsController < ApplicationController
      def index
        @products = Product.all
        render status: :ok, json: @products.map { |p| ProductSerializer.new(p).as_json }
      end
    end
  end
end
