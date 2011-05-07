Geocoder::Configuration.lookup = :google
Geocoder::Configuration.timeout = 1

if ENV['RAILS_ENV'] == 'production'
  Geocoder::Configuration.api_key = "ABQIAAAAuCa-3icg51FeRNcYL7WhiBTF6bzZDgf24EzXlEb1urVKT1DBZxRjlpMqWAMHc4_5ga8MwX9DReM1Sw"
else
  Geocoder::Configuration.api_key = "ABQIAAAAuCa-3icg51FeRNcYL7WhiBTJQa0g3IQ9GZqIMmInSLzwtGDKaBTapNNv32SFVGtU8j4NxiJA3JIwJA"
end
