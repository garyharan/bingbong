gary = User.create! :id => 1, :email => "gary.haran@gmail.com", :password => "testing", :first_name => "Gary", :last_name => "Haran", :admin => true
gary.confirm!

ayman = User.create! :id => 2, :email => "ayman_unik@gmail.com", :password => "testing", :first_name => "Ayman", :last_name => "Unik"
ayman.confirm!
