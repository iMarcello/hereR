% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/route_matrix.R
\name{route_matrix}
\alias{route_matrix}
\title{HERE Routing API: Route Matrix}
\usage{
route_matrix(
  start,
  destination = start,
  type = "fastest",
  mode = "car",
  traffic = FALSE,
  searchRange = 99999999,
  attribute = c("distance", "traveltime"),
  departure = NULL,
  url_only = FALSE
)
}
\arguments{
\item{start}{\code{sf} object, Points of Interest (POIs) of geometry type \code{POINT} for the start locations.}

\item{destination}{\code{sf} object, Points of Interest (POIs) of geometry type \code{POINT} for the destination locations.}

\item{type}{character, set the routing type: \code{"fastest"}, \code{"shortest"} or \code{"balanced"}.}

\item{mode}{character, set the transport mode: \code{"car"}, \code{"pedestrian"}, \code{"carHOV"} or \code{"truck"}.}

\item{traffic}{boolean, use real-time traffic or prediction in routing (\code{default = FALSE})? If no \code{departure} date and time is set, the current timestamp at the moment of the request is used for \code{departure}.}

\item{searchRange}{numeric, value in meters to limit the search radius in the route generation (\code{default = 99999999}).}

\item{attribute}{character, attributes to be calculated on the routes: \code{"distance"} or \code{"traveltime"} (\code{default = c("distance", "traveltime")}.}

\item{departure}{datetime, timestamp of type \code{POSIXct}, \code{POSIXt} for the departure.}

\item{url_only}{boolean, only return the generated URLs (\code{default = FALSE})?}
}
\value{
A \code{data.table} containing the requested route matrix data.
}
\description{
Calculates a matrix of route summaries between given points of interest (POIs).
Various transport modes and traffic information at a provided timestamp are supported.
The requested matrix is split into (sub-)matrices of dimension 15x100 to use the
maximum matrix size per request and thereby minimize the number of overall needed requests.
The result is one route summary matrix, that fits the order of the provided POIs: \code{startIndex}, \code{destinationIndex}.
}
\examples{
# Provide an API Key for a HERE project
set_key("<YOUR API KEY>")

# Create routes summaries between all POIs
mat <- route_matrix(
  start = poi,
  departure = as.POSIXct("2019-10-10 15:45:00"),
  traffic = TRUE,
  url_only = TRUE
)
}
\references{
\href{https://developer.here.com/documentation/routing/topics/resource-calculate-matrix.html}{HERE Routing API: Calculate Matrix}
}
