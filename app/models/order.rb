class Order < ActiveRecord::Base
  attr_accessible :address, :email, :name, :pay_types
  PAYMENT_TYPES = ["a","b","c","d"]
  validates :name,:address,:email,:pay_types,:presence => true
  validates :pay_types,:inclusion => PAYMENT_TYPES
  has_many :line_items#,:dependent => destroy
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
end
