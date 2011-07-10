class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :remember_me, :first_name, :last_name

  #validates_uniqueness_of :email
  validates_presence_of :email, :first_name, :last_name, :delivery_address

  belongs_to :delivery_address

  has_many :shops
  has_many :lines

  has_many :searches
  has_many :orders

  def name
    [first_name, last_name].join(' ')
  end
end
