# README

This Ruby on Rails application is intended to serve as an API for a weather forecast based on an address or a zip code.

### Stack
* Ruby version 3.1.1
* Rails version 7.0.8

### Configuration
This application uses [dotenv](https://github.com/bkeepers/dotenv) to validate that the necessary environment variables are properly set. Please take a look at the [env example](https://github.com/andresviviani1/weather-forecast/blob/master/weather-forecast-api/.env.example) for the necessary env variables

### Tets
Rspec is configured for testing. Run `bundle exec rspec` to execute all tests.

### Patterns
* This application make use of [Service Objects](https://www.toptal.com/ruby-on-rails/rails-service-objects-tutorial) and [Presenters](https://www.rubyguides.com/2019/09/rails-patterns-presenter-service/)


### External services
- [Geolocation](https://apidocs.geoapify.com/docs/geocoding/forward-geocoding/#about)
- [Weather information](https://openweathermap.org/)


### Misc
- Factory Bot and Faker are configured to be used
- API documentation can be found at the `/api-docs` route (created with Swagger)
- Rubocop is available to use. This helps with general ruby and also rails code standards.
