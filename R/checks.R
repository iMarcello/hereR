.check_addresses <- function(addresses) {
  if (!is.character(addresses)) stop("'addresses' must be a 'character' vector.")
  if (any(is.na(addresses))) stop("'addresses' contains NAs.")
  if ("" %in% gsub(" ", "", addresses)) stop("'addresses' contains empty strings.")
}

.check_points <- function(points) {
  if (!"sf" %in% class(points))
      stop("'points' must be an sf object.")
  if (any(sf::st_is_empty(points)))
    stop("'points' has empty entries in the geometry column.")
  if (any(sf::st_geometry_type(points) != "POINT"))
      stop("'points' must be an sf object with geometry type 'POINT'.")
}

.check_polygon <- function(polygon) {
  if (!"sf" %in% class(polygon))
    stop("'polygon' must be an sf object.")
  if (any(sf::st_is_empty(polygon)))
    stop("'polygon' has empty entries in the geometry column.")
  if (!"sf" %in% class(polygon) |
      any(!(sf::st_geometry_type(polygon) %in% c("POLYGON", "MULTIPOLYGON"))))
    stop("'polygon' must be an sf object with geometry type 'POLYGON' or 'MULTIPOLYGON'.")
}

.check_boolean <- function(bool) {
  if (!bool %in% c(TRUE, FALSE))
    stop(sprintf("'%s' must be a 'boolean' value.", deparse(substitute(bool))))
}

.check_datetime <- function(datetime) {
  if (!any(class(Sys.time()) %in% c("POSIXct", "POSIXt")))
    stop("'datetime' must be of type 'POSIXct', 'POSIXt'.")
}

.check_datetime_range <- function(from, to) {
  if (from > to)
    stop("Invalid datetime range: 'from' must be smaller than 'to'.")
}

.check_mode <- function(mode, request) {
  modes <- c("car", "pedestrian", "carHOV", "publicTransport",
             "publicTransportTimeTable", "truck", "bicycle")

  if (request == "calculateisoline") {
    modes <- modes[c(1, 2, 6)]
    if (!mode %in% modes)
      stop(.stop_print_modes(mode = mode, modes = modes, request = request))

  } else if (request == "calculatematrix") {
    modes <- modes[c(1, 2, 3, 6)]
    if (!mode %in% modes)
      stop(.stop_print_modes(mode = mode, modes = modes, request = request))

  } else if (request == "calculateroute") {
    modes <- modes[c(1, 2, 3, 4, 6, 7)]
    if (!mode %in% modes)
      stop(.stop_print_modes(mode = mode, modes = modes, request = request))

  } else {
    stop(sprintf("'%s' is an invalid request type.", request))
  }
}

.stop_print_modes <- function(mode, modes, request) {
  sprintf("Transport mode '%s' not valid. For '%s' requests the mode must be in ('%s').",
          mode,
          request,
          paste(modes, collapse = "', '"))
}

.check_type <- function(type, request) {
  types <- c("fastest", "shortest", "balanced")

  if (request == "calculateisoline") {
    types <- types[c(1, 2)]
    if (!type %in% types)
      stop(.stop_print_types(type = type, types = types, request = request))

  } else if (request == "calculatematrix" | request == "calculateroute") {
    if (!type %in% types)
      stop(.stop_print_types(type = type, types = types, request = request))

  } else {
    stop(sprintf("'%s' is an invalid request type.", request))
  }
}

.stop_print_types <- function(type, types, request) {
  sprintf("Routing type '%s' not valid. For '%s' requests the type must be in ('%s').",
          type,
          request,
          paste(types, collapse = "', '"))
}

.check_attributes <-  function(attribute) {
  attributes <- c("distance", "traveltime")
  if (any(!attribute %in% attributes))
    stop(sprintf("'attribute' must be in '%s'.", paste(attributes, collapse = "', '")))
}

.check_rangetype <- function(rangetype) {
  rangetypes <- c("distance", "time", "consumption")
  if (!rangetype %in% rangetypes)
    stop(sprintf("'rangetype' must be '%s'.", paste(rangetypes, collapse = "', '")))
}

.check_proxy <- function(proxy) {
  if (!is.null(proxy)) {
    if (!is.character(proxy))
      stop("'proxy' must be of type 'character'.")
    if (!strsplit(proxy, "://")[[1]][1] %in% c("http", "https"))
      stop("'proxy' is not in the required format: 'http://your-proxy.com:port/' or 'https://your-proxy.org:port/'.")
  }
}

.check_proxyuserpwd <- function(proxyuserpwd) {
  if (!is.null(proxyuserpwd)) {
    if (!is.character(proxyuserpwd))
      stop("'proxyuserpwd' must be of type 'character'.")
    if (length(strsplit(proxyuserpwd, ":")[[1]]) != 2)
      stop("'proxyuserpwd' is not in the required format: 'user:pwd'.")
  }
}

.check_key <- function(api_key) {
  if (!(is.character(api_key) & api_key != ""))
    stop("Please provide an 'API key' for a HERE project.
         Get your login here: https://developer.here.com/")
}

.check_vehicle_type <- function(vehicle_type) {
  vehicle_types <- c("diesel", "gasoline", "electric")
  if (!strsplit(vehicle_type, ",")[[1]][1] %in% vehicle_types)
    stop(sprintf("'vehicle_type' must be '%s'.", paste(vehicle_types, collapse = "', '")))
}

.check_weather_product <- function(product) {
  weather_product_types <- c("observation", "forecast_hourly", "forecast_astronomy", "alerts")
  if (!product %in% weather_product_types)
    stop(sprintf("'product' must be '%s'.", paste(weather_product_types, collapse = "', '")))
}

.check_traffic_product <- function(product) {
  traffic_product_types <- c("flow", "incidents")
  if (!product %in% traffic_product_types)
    stop(sprintf("'product' must be '%s'.", paste(traffic_product_types, collapse = "', '")))
}

.check_min_jam_factor <- function(min_jam_factor) {
  if (!is.numeric(min_jam_factor))
    stop("'min_jam_factor' must be of type 'numeric'.")
  if (min_jam_factor < 0 | min_jam_factor > 10)
    stop("'min_jam_factor' must be in the valid range from 0 to 10.")
}

.check_max_results <- function(results) {
  if (!is.numeric(results))
    stop("'results' must be of type 'numeric'.")
  if (results < 1 | results > 20)
    stop("'results' must be in the valid range from 1 to 20.")
}
