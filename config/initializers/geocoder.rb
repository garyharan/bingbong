Geocoder::Configuration.lookup = :google
Geocoder::Configuration.timeout = 1

# Google doesn't require an API key anymore, thus we use this instead.
Geocoder::Configuration.api_key = ENV["GOOGLE_MAPS_API_KEY"] || ""
