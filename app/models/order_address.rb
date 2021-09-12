class OrderAddress
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :town, :house_number, :building, :phone_number, :item_id, :user_id, :order_id, :token

  with_options presence: true do
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :town, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'is invalid. Input full-width characters.' }
    validates :house_number
    validates :phone_number, format: { with: /\A[0-9]+\z/ }
    validates :item_id
    validates :user_id
    validates :token
  end
  validates :prefecture_id, numericality: {other_than: 1, message: "can't be blank"}

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Address.create(post_code: post_code, prefecture_id: prefecture_id, town: town, house_number: house_number, building: building, phone_number: phone_number, order_id: order.id)
  end
end