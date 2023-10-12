# frozen_string_literal: true

module Api
  module V1
    class WeatherController < ApplicationController
      def show
        cache_key = "weather_by_zip_code/#{params[:zip_code]}"
        cached_response = Rails.cache.fetch(cache_key)

        response = cached_response || store_cache(cache_key)

        presented_weather = Weather::ByZipCodePresenter.new(response, cached: !cached_response.nil?)
        render jsonapi: presented_weather, class: { 'Weather::ByZipCodePresenter': Weather::SerializableByZipCode }
      rescue RestClient::NotFound
        render jsonapi: nil, status: :not_found
      rescue RestClient::Unauthorized
        render jsonapi: nil, status: :unauthorized
      rescue RestClient::Forbidden
        render jsonapi: nil, status: :forbidden
      rescue RestClient::BadRequest
        render jsonapi: nil, status: :bad_request
      rescue StandardError
        render jsonapi: nil, status: :internal_server_error
      end

      private

      def store_cache(cache_key)
        Rails.cache.fetch(cache_key, expires_in: 30.minutes) do
          Weather::ByZipCodeService.execute(params[:zip_code])
        end
      end
    end
  end
end
