module ShopsHelper
  def map_url(shop)
    raw [ "http://maps.google.com/maps/api/staticmap?",
      'size=230x162', # seriously?   If I use 400x300 it blows up
      "&zoom=13",
      "&markers=size:mid|color:0xE35524|",
      CGI.escape(shop.full_address.split(',').map{|p| p.strip }.join(',')),
      "&sensor=false" ].join('')
  end
end
