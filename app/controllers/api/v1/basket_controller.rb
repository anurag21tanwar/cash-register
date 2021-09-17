# frozen_string_literal: true

module Api
  module V1
    class BasketController < ApplicationController
      def show
        render status: :ok, json: BasketSerializer.new(@current_basket).as_json
      end
    end
  end
end
