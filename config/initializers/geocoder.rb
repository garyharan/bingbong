Geocoder::Configuration.lookup = :geocoder_ca
Geocoder::Configuration.timeout = 3

if Rails.env.production?
  puts "Using geocoder.ca key."
  Geocoder::Configuration.api_key = "686674307166573397008x1696"
end
