class OrderItem < ActiveRecord::Base
  
  extend FriendlyId
    friendly_id :name, use: :slugged
  
  belongs_to :roast
  belongs_to :order
  
  has_many :sales
  
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :roast_present
  validate :order_present

  before_save :finalize

  def unit_price
    if persisted?
      self[:unit_price]
    else
      roast.price
    end
  end

  def total_price
    unit_price * quantity
  end

private
  def roast_present
    if roast.nil?
      errors.add(:roast, "is not valid or is not active.")
    end
  end

  def order_present
    if order.nil?
      errors.add(:order, "is not a valid order.")
    end
  end

  def finalize
    self[:unit_price] = unit_price
    self[:total_price] = quantity * self[:unit_price]
  end
end
