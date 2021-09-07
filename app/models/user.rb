class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :orders

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  ZENKAKU_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/.freeze
  KANA_REGEX = /\A[ァ-ヶー－]+\z/.freeze

  validates_format_of :password, with: PASSWORD_REGEX, message: 'should be contain both letters and numbers.'

  with_options presence: true do
    validates :nickname
    validates :last_name, format: { with: ZENKAKU_REGEX, message: 'is invalid. Input full-width characters.' }
    validates :first_name, format: { with: ZENKAKU_REGEX, message: 'is invalid. Input full-width characters.' }
    validates :last_name_kana, format: { with: KANA_REGEX, message: 'is invalid. Input full-width katakana characters.' }
    validates :first_name_kana, format: { with: KANA_REGEX, message: 'is invalid. Input full-width katakana characters.' }
    validates :birthday
  end
end
