class Customer < User
  has_many :addresses, foreign_key: 'user_id', dependent: :destroy
  accepts_nested_attributes_for :addresses
end
