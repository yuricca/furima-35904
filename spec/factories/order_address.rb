FactoryBot.define do
  factory :order_address do
    post_code       { '123-4567' }
    prefecture_id   { 2 }
    town            { '横浜市西区' }
    house_number    { '海岸通1-1' }
    building        { '横浜第１ビル' }
    phone_number    { '09012345678' }
    token { 'tok_abcdefghijk00000000000000000' }
    association :user
    association :item
  end
end
