require "net/http"
require "uri"
require "cgi"

$orders = CGI::unescape($orders)
$name = CGI::unescape($name)
$address = CGI::unescape($address)
$shop_name = CGI::unescape($shop_name)

def answer_server(answer)
  count = 0
  while count < 3
    message = {
      :result => answer[:result].to_s,
      :code => $code
    }
    url = URI.parse("#{$url}/shops/#{$shop_id}/orders/#{$order_id}/tropo_answer")

    req = Net::HTTP::Post.new(url.path)
    req.set_form_data(message, ';')
    res = Net::HTTP.new(url.host, url.port).start {|http| http.request(req) }
    case res
    when Net::HTTPSuccess
      break
    else
      log "CALLBACK ERROR -> count : #{count}, shop_id : '#{$shop_id}', order_id : '#{$order_id}', result : '#{answer[:result]}', code : '#{$code}' => #{res.error}"
      count += 1
    end
  end
end

def slow_message(message)
  #"<prosody rate='-95%'>#{message}</prosody>"
  message
end

def talk(message)
  say("<speak>#{message}</speak>", :voice => "Juliette")
end

def new_options(digit, message, &block)
  {:digit => digit, :message => message, :block => block}
end

menu_options = {}
menu_options["1"] = new_options("1", "répéter la commande") do
  {:to_say => [:order]}
end
menu_options["2"] = new_options("2", "répéter le nom") do
  {:to_say => [:name]}
end
menu_options["3"] = new_options("3", "répéter l'adresse") do
  {:to_say => [:address]}
end
menu_options["4"] = new_options("4", "tout répéter") do
  {:to_say => [:order, :name, :address]}
end
#menu_options["6"] = new_options("6", "appeler le client") do
#  {:transfert => true}
#end
menu_options["*"] = new_options("étoile", "accepter la commande") do
  talk("Vous avez accepté la commande. Merci!")
  {:result => :accept}
end
menu_options["#"] = new_options("carré", "refuser la commande") do
  talk("Vous refusez la commande. Au revoir.")
  {:result => :refuse}
end

# Say strings
orders_string = $orders.split(";").map do |order|
    slow_message(order)
  end.join(". ") + ". "

name_string = "#{$name}."

address_string = "#{$address.gsub(/(\d+)/, "<say-as interpret-as='vxml:digits'>\\1</say-as>")}. "

menu_string =  menu_options.map do |digit, o|
    "Faites le #{o[:digit]} pour #{o[:message]}"
  end.join(", ") + ". "

call("+1#{$number}");

talk("Bonjour #{$shop_name}.")

stop = false;
to_say = [:order, :name, :address]
answer = nil
while (!stop) do
  asked_string = ""

  if to_say.include? :order
    asked_string << orders_string
  end

  if to_say.include? :name
    asked_string << name_string
  end

  if to_say.include? :address
    asked_string << address_string
  end

  asked_string << menu_string

  log "SPOKEN string : #{asked_string}"
  result = ask("<speak>#{asked_string}</speak>",
    :mode => "dtmf",
    :choices => menu_options.keys.join(","),
    :attempts => 99,
    :voice => "Florence",
    :recognizer => "fr-ca",
    :bargein => true,
    :onBadChoice => lambda { |event|
      # Oops
      nil
    },
      :onHangup => lambda { |event|
      # Oops
      nil
    },
      :onTimeout => lambda { |event|
      #Oops
      nil
    }
  )

  if result.choice.nil?
    log("SCRIPT_LOGGING : Hangup during selection")
    answer = {:result => "hangup"}
    break
  else
    log("SCRIPT_LOGGING : result.value: #{result.value}, event.choice.utterance: #{result.choice.utterance}, event.choice.interpretation: #{result.choice.interpretation}");
  end
  answer = menu_options.fetch(result.value) do
    block = lambda do
      talk("Je n'ai pas reconnu votre réponse.")
      {:to_say => "menu"}
    end
    {:block => block}
  end[:block].call

  to_say = answer[:to_say]
  stop = true if answer[:result]
end

answer_server(answer)

hangup();
