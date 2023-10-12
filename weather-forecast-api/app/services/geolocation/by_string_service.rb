# frozen_string_literal: true

module Geolocation
  class ByStringService < ApplicationService
    def initialize(search_string)
      super()
      @search_string = search_string
    end

    # More info: https://apidocs.geoapify.com/docs/geocoding/forward-geocoding/#about
    def execute
      response = RestClient.get(
        'https://api.geoapify.com/v1/geocode/search',
        {
          params: {
            text: @search_string,
            apiKey: ENV['GEOLOCATION_API_KEY'],
            format: 'json'
          }
        }
      )
      JSON.parse response.body
    end
  end
end
