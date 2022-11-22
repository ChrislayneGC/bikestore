FactoryGirl.define do
  factory :address do
    user nil
    kind "MyString"
    street "MyString"
    district "MyString"
    number "MyString"
    zipcode "MyString"
    city "MyString"
    state "MyString"
    country "MyString"
    latitude 1.5
    longitute 1.5
    active false
  end
end
