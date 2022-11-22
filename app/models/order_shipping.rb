class OrderShipping < ActiveRecord::Base
  belongs_to :order


  def to_s
    [street, district, city, state].join('-')
  end
end
