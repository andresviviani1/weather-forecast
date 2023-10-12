# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Weather', type: :request do
  before :example do
    allow(Geolocation::ByStringService).to receive(:execute).and_return(
      {
        results: [
          {
            datasource: {
              sourcename: 'openstreetmap',
              attribution: '© OpenStreetMap contributors',
              license: 'Open Database License',
              url: 'https://www.openstreetmap.org/copyright'
            },
            country: 'United States',
            country_code: 'us',
            state: 'Florida',
            county: 'Broward County',
            city: 'Coral Springs',
            postcode: '33065',
            street: 'Northwest 43rd Street',
            housenumber: '8375',
            lon: -80.23744303030949,
            lat: 26.283059970581682,
            state_code: 'FL',
            formatted: '8375 Northwest 43rd Street, Coral Springs, FL 33065, United States of America',
            address_line1: '8375 Northwest 43rd Street',
            address_line2: 'Coral Springs, FL 33065, United States of America',
            timezone: {
              name: 'America/New_York',
              offset_STD: '-05:00',
              offset_STD_seconds: -18_000,
              offset_DST: '-04:00',
              offset_DST_seconds: -14_400,
              abbreviation_STD: 'EST',
              abbreviation_DST: 'EDT'
            },
            plus_code: '76RX7QM7+62',
            plus_code_short: '7QM7+62 Coral Springs, Broward County, United States',
            result_type: 'building',
            rank: {
              importance: -0.8399999999999999,
              popularity: 3.721255299263749,
              confidence: 1,
              match_type: 'full_match'
            },
            place_id: '51ea754044320f54c0597e74449e76483a40f00102f90138bfa40000000000c00203',
            bbox: {
              lon1: -80.237493030309,
              lat1: 26.283009970582,
              lon2: -80.237393030309,
              lat2: 26.283109970582
            }
          }
        ],
        query: {
          text: '8375 NW 43rd st',
          parsed: {
            housenumber: '8375',
            street: 'nw 43rd st',
            expected_type: 'building'
          }
        }
      }
    )
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
  end

  describe 'get weather information for an address' do
    it 'should return weather information' do
      get '/api/v1/weather', params: { address: '8375 NW 43rd st' }
      json = JSON.parse(response.body)
      expect(json['data']['attributes']['min']).to eql(79)
      expect(json['data']['attributes']['max']).to eql(86)
    end
  end

  describe 'get weather information for a zip code' do
    it 'should return weather information' do
      get '/api/v1/weather', params: { zip_code: 33_131 }
      json = JSON.parse(response.body)

      expect(json['data']['attributes']['min']).to eql(79)
      expect(json['data']['attributes']['max']).to eql(86)
    end
  end
end
