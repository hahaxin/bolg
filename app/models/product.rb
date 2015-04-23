class Product < ActiveRecord::Base
  attr_accessible :description, :img_url, :price, :title,:id
  validates :title,:description,:img_url,:presence => true
  validates :price,:numericality => {:greater_than_or_equal_to => 0.01}
  validates :title,:uniqueness => true
  validates :img_url,:format => {
      :with => %r{\.(gif|jpg|png)$}i,
      :message => 'must be a url for imgage'
  }
  default_scope :order => 'title'
  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item
  private
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base,'Line Item present')
      return false
    end
  end
end
