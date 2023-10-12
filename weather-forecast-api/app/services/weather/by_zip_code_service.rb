# frozen_string_literal: true

module Weather
  # Limited to US zipcodes only for now
  # TODO: add support for other countries
  class ByZipCodeService < ApplicationService
    def initialize(zip_code)
      super()
      @zip_code = zip_code
    end

    # More info: https://openweathermap.org/
    def execute
      response = RestClient.get(
        'https://api.openweathermap.org/data/2.5/weather',
        {
          params: {
            zip: "#{@zip_code},us",
            appid: ENV['WEATHER_API_KEY'],
            units: 'imperial'
          }
        }
      )
      JSON.parse response.body
    end
  end
end
