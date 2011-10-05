class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :remember_me, :first_name, :last_name

  validates_uniqueness_of :email
  validates_presence_of :email, :first_name, :last_name

  has_many :shops,              :foreign_key => :owner_id

  has_many :lines,              :foreign_key => :client_id
  has_many :searches,           :foreign_key => :client_id
  has_many :delivery_addresses, :foreign_key => :client_id
  has_many :orders,             :through => :delivery_addresses

  def name
    [first_name, last_name].join(' ')
  end

  def all_orders
    Order.where(:delivery_address_id => DeliveryAddress.where(:client_id => id))
  end

  def active_for_authentication?
    true # Confirmation is not mandatory
  end
end
