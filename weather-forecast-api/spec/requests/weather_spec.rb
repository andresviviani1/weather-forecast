# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Weather', type: :request do
  describe 'get weather information for a zip code' do
    it 'should return weather information' do
      allow(Weather::ByZipCodeService).to receive(:execute).and_return(
        {
          coord: { lon: -80.2926, lat: 25.8301 },
          weather: [{ id: 801, main: 'Clouds', description: 'broken clouds', icon: '04n' }],
          base: 'stations',
          main: { temp: 82.51, feels_like: 93.42, temp_min: 79.02, temp_max: 86, pressure: 1009, humidity: 91 },
          visibility: 10_000,
          wind: { speed: 3.09, deg: 80 },
          clouds: { all: 75 },
          dt: 1_697_067_893,
          sys: { type: 2, id: 2_000_390, country: 'US', sunrise: 1_697_023_061, sunset: 1_697_065_075 },
          timezone: -14_400,
          id: 0,
          name: 'Miami',
          cod: 200
        }
      )
      get '/weather', params: { zip_code: 33_131 }
      json = JSON.parse(response.body)

      expect(json['data']['attributes']['min']).to eql(79)
      expect(json['data']['attributes']['max']).to eql(86)
    end
  end
end
