# frozen_string_literal: true

module Weather
  class ByZipCodePresenter < SimpleDelegator
    attr_accessor :cached

    def initialize(weather_hash, cached: false)
      super(weather_hash)
      @weather = weather_hash.with_indifferent_access
      self.cached = cached
    end

    def date
      Time.zone.at(@weather[:dt]).strftime('%b %d, %Y')
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
