Geocoder::Configuration.lookup = :google
Geocoder::Configuration.timeout = 1

if ENV.to_hash.has_key?("GOOGLE_MAPS_API_KEY") then
  puts "Using ENV Google Maps API key"
  Geocoder::Configuration.api_key = ENV["GOOGLE_MAPS_API_KEY"]
else
  if Rails.env.production? then
    puts "Using PRODUCTION Google Maps API key"
    Geocoder::Configuration.api_key = "ABQIAAAAuCa-3icg51FeRNcYL7WhiBTF6bzZDgf24EzXlEb1urVKT1DBZxRjlpMqWAMHc4_5ga8MwX9DReM1Sw"
  else
    puts "Using DEVELOPMENT / TEST Google Maps API key"
    Geocoder::Configuration.api_key = "ABQIAAAAuCa-3icg51FeRNcYL7WhiBTJQa0g3IQ9GZqIMmInSLzwtGDKaBTapNNv32SFVGtU8j4NxiJA3JIwJA"
  end
end
