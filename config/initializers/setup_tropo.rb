TROPO_SESSION_API_URL = "http://api.tropo.com/1.0/sessions"
TROPO_TOKEN_ID        = "063c1f9591501445b006b4a811cf9c4261fe84980b023c460fa3abdb399b5a80c36a52e7cc33077bee4d3331"

if Rails.env.production?
  TROPO_CALLBACK_ADDRESS = "http://grandmenu.com"
else
  TROPO_CALLBACK_ADDRESS = "http://grandmenu.com"
  #TROPO_CALLBACK_ADDRESS = "http://dons-amateurs.teksol.info:3000"
end
