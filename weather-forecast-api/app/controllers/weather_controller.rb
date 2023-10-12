# frozen_string_literal: true

class WeatherController < ApplicationController
  def show
    response = Weather::ByZipCodeService.execute(params[:zip_code])
    presented_weather = Weather::ByZipCodePresenter.new(response)
    render jsonapi: presented_weather, class: { 'Weather::ByZipCodePresenter': Weather::SerializableByZipCode }
  rescue RestClient::NotFound
    render jsonapi: nil, status: :not_found
  rescue RestClient::Unauthorized
    render jsonapi: nil, status: :unauthorized
  rescue RestClient::Forbidden
    render jsonapi: nil, status: :forbidden
  rescue StandardError
    render jsonapi: nil, status: :internal_server_error
  end
end
