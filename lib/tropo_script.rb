def slow_message(message)
  "<prosody rate='-95%'>#{message}</prosody>"
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
menu_options["6"] = new_options("6", "appeler le client") do
  {:transfert => true}
end
menu_options["*"] = new_options("étoile", "accepter la commande") do
  talk("Vous avez accepté la commande. Merci!")
  {:result => :accepted}
end
menu_options["#"] = new_options("carré", "refuser la commande") do
  talk("Vous refusez la commande. Au revoir.")
  {:result => :refused}
end

# Say strings
orders_string = $orders.split(";").map do |order|
    slow_message(order)
  end.join(".") + ". "

name_string = "#{$name}."

address_string = "#{$address.gsub(/(\d+)/, "<say-as interpret-as='vxml:digits'>\\1</say-as>")}. "

menu_string =  menu_options.map do |digit, o|
    "Faites le #{o[:digit]} pour #{o[:message]}"
  end.join(", ") + ". "

call("+1#{$number}");

talk("Bonjour #{$shop_name}.")

accepted = false;
to_say = [:order, :name, :address]
while (!accepted) do
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

  result = ask("<speak>#{asked_string}</speak>",
    :mode => "dtmf",
    :choices => menu_options.keys.join(","),
    :attempts => 99,
    :voice => "Juliette",
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

  log("SCRIPT_LOGGING : result.value: #{result.value}, event.choice.utterance: #{result.choice.utterance}, event.choice.interpretation: #{result.choice.interpretation}");

  r = menu_options.fetch(result.value) do
    block = lambda do
      talk("Je n'ai pas reconnu votre réponse.")
      {:to_say => "menu"}
    end
    {:block => block}
  end[:block].call

  to_say = r[:to_say]
  accepted = true if r[:result]
end

hangup();
