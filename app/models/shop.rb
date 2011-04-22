class Shop < ActiveRecord::Base
  belongs_to :user

  def owned_by?(owner)
    owner.id == user_id
  end
end
