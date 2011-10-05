#deep.hornet32

require "net/http"
require "uri"

#url = URI.parse('http://www.localhost:3000')
#res = Net::HTTP.start(url.host, url.port) {|http|
#        http.put('/orders/index.html')
#            }
#res = Net::HTTP.post_form(URI.parse('http://www.example.com/search.cgi'),
#                          {'q' => 'ruby', 'max' => '50'})
#puts res.body

shop_id = 2
order_id = 1
message = {
  :result => "accept", #refuse
  :code => "asdfbadeg"
}
url = URI.parse("dons-amateurs.teksol.info:3000/shops/#{shop_id}/orders/#{order_id}/tropo_answer")

req = Net::HTTP::Post.new(url.path)
#req.basic_auth 'bingbong', '1jfajb2jrf83j'
req.set_form_data(message, ';')
res = Net::HTTP.new(url.host, url.port).start {|http| http.request(req) }
case res
when Net::HTTPSuccess
  # OK
else
  res.error!
end
