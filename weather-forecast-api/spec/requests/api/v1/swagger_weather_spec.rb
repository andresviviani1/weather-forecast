# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/weather', type: :request do
  # TODO: add 404 test
  path '/api/v1/weather' do
    get 'Retrieves weather information by zip code' do
      let (:zip_code) { 33131 }
      tags 'Weather'
      produces 'application/json'
      parameter name: :zip_code, in: :query, type: :number, description: 'Zip code'

      response '200', 'Weather information' do
        schema type: :object,
               properties: {
                 data: {
                   type: :object,
                   properties: {
                     id: { type: :string, example: '804' },
                     type: { type: :string, example: 'weather_by_zip_code' },
                     attributes: {
                       type: :object,
                       properties: {
                        date: {type: :string, description: 'Date in format %Y-%m-%d', example: '2023-10-12'},
                         current: { type: :number, description: 'Current temperature', example: 73 },
                         min: { type: :number, description: 'Minimum temperature', example: 70 },
                         max: { type: :number, description: 'Maximum temperature', example: 78 },
                         feels_like: { type: :number, description: 'Thermal sensation', example: 75 },
                         humidity: { type: :number, description: 'Humidity percentage', example: 73 },
                         cached: { type: :boolean, description: 'Cached result', example: true }
                       }
                     }
                   }
                 },
                 jsonapi: {
                   type: :object,
                   properties: {
                     version: { type: :string, example: '1.0' }
                   }
                 }
               }
        run_test!
      end
    end
  end
end
