# frozen_string_literal: true

module Weather
  class ByZipCodePresenter < SimpleDelegator
    def initialize(weather_hash)
      super
      @weather = weather_hash.with_indifferent_access
    end

    def id
      @weather[:weather][0][:id]
    end

    def current
      @weather[:main][:temp].to_i
    end

    def min
      @weather[:main][:temp_min].to_i
    end

    def max
      @weather[:main][:temp_max].to_i
    end

    def feels_like
      @weather[:main][:feels_like].to_i
    end

    def humidity
      @weather[:main][:humidity].to_i
    end
  end
end
