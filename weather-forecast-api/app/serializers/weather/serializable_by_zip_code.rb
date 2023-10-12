# frozen_string_literal: true

# Follows the jsonapi convention about naming
module Weather
  class SerializableByZipCode < JSONAPI::Serializable::Resource
    type 'weather_by_zip_code'

    attributes :current, :min, :max, :feels_like, :humidity, :cached
  end
end
