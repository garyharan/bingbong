class Shop < ActiveRecord::Base
  belongs_to :owner, :class_name => "User"
  has_many :orders
  has_many :categories, :order => 'created_at ASC'
  has_many :time_blocks

  scope :opened, lambda {
    t = Time.now
    current_time = t.strftime("%H%M")
    joins(:time_blocks).
    where("time_blocks.starting <= #{current_time} AND time_blocks.ending >= #{current_time} AND time_blocks.weekday = #{t.wday}")
  }

  def open?
    t = Time.now
    current_time = t.strftime("%H%M")
    time_blocks.where("starting <= #{current_time} AND ending >= #{current_time} AND weekday = #{t.wday}").count > 0
  end

  geocoded_by :full_address
  after_validation :geocode
  before_validation do
    normalized = self.postal_code.to_s.upcase.gsub(/[^A-Z0-9]/, "")
    normalized = "#{normalized[0, 3]} #{normalized[3, 3]}"
    self.postal_code = normalized
  end

  def full_address
    [address, city, province, postal_code].join(", ")
  end

  def owned_by?(owner)
    self.owner == owner
  end

  def delivery_fee_to(order)
    BigDecimal.new("0")
  end

  # TODO: Move to database-backed table/column
  def gst_rate
    BigDecimal.new("0.05")
  end

  # TODO: Move to database-backed table/column
  def pst_rate
    BigDecimal.new("0.085")
  end
end
