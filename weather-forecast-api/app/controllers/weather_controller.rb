# frozen_string_literal: true

class WeatherController < ApplicationController
  def show
    response = Weather::ByZipCodeService.execute(params[:zip_code])
    presented_weather = Weather::ByZipCodePresenter.new(response)
    render jsonapi: presented_weather, class: { 'Weather::ByZipCodePresenter': Weather::SerializableByZipCode }
  end
end
