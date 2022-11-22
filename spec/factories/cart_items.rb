FactoryGirl.define do
  factory :cart_item do
    cart nil
    product nil
    quantity 1
    price "9.99"
    total "9.99"
  end
end
