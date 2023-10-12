# frozen_string_literal: true

module Api
  module V1
    class WeatherController < ApplicationController
      def show
        # TODO: add better error handling. E.g: zip code format
        # TODO: This is not the most accurate error, but it does the job
        raise RestClient::BadRequest if params[:zip_code].blank? && params[:address].blank?

        zip_code = params[:zip_code]
        if zip_code.blank?
          addresses = Geolocation::ByStringService.execute(params[:address]).with_indifferent_access
          address = addresses['results'][0]
          zip_code = address['postcode']
        end
        render jsonapi: presented_weather(zip_code), class: { 'Weather::ByZipCodePresenter': Weather::SerializableByZipCode }
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

      def presented_weather(zip_code)
        cache_key = "weather_by_zip_code/#{zip_code}"
        cached_response = Rails.cache.fetch(cache_key)

        response = cached_response || store_cache(cache_key, zip_code)

        Weather::ByZipCodePresenter.new(response, cached: !cached_response.nil?)
      end

      def store_cache(cache_key, zip_code)
        Rails.cache.fetch(cache_key, expires_in: 30.minutes) do
          Weather::ByZipCodeService.execute(zip_code)
        end
      end
    end
  end
end
