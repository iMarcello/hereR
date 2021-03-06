test_that("weather forecast_astronomy works", {
  # Set dummy key
  set_key("dummy_api_key")

  # Load package example data
  data(poi)

  # Test with API response mock
  with_mock(
    "hereR:::.get_content" = function(url) {hereR:::mock$weather_forecast_astronomy_response},
    weather_forecast_astronomy <- weather(poi = poi, product = "forecast_astronomy"),

    # Tests
    expect_equal(any(sf::st_geometry_type(weather_forecast_astronomy) != "POINT"), FALSE),
    expect_equal(nrow(weather_forecast_astronomy), nrow(poi))
  )
})
