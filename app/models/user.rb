class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :remember_me, :first_name, :last_name

  validates_presence_of :first_name
  validates_presence_of :last_name

  has_many :shops
  has_many :lines
  
  has_many :searches
  has_many :orders

  def name
    [first_name, last_name].join(' ')
  end
end
