FactoryGirl.define do
  factory :order_shipping do
    order nil
    kind "MyString"
    street "MyString"
    district "MyString"
    number "MyString"
    zipcode "MyString"
    city "MyString"
    state "MyString"
    country "MyString"
    latitude 1.5
    longitude 1.5
    status "MyString"
  end
end
