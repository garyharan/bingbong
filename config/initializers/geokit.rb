Geokit::default_units = :kms
Geokit::default_formula = :sphere

if ENV['RAILS_ENV'] == 'production'
  Geokit::Geocoders::google = "ABQIAAAAuCa-3icg51FeRNcYL7WhiBTF6bzZDgf24EzXlEb1urVKT1DBZxRjlpMqWAMHc4_5ga8MwX9DReM1Sw"
else
  Geokit::Geocoders::google = "ABQIAAAAuCa-3icg51FeRNcYL7WhiBTJQa0g3IQ9GZqIMmInSLzwtGDKaBTapNNv32SFVGtU8j4NxiJA3JIwJA"
end
