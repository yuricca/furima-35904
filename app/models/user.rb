class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  ZENKAKU_REGEX = /\A[ぁ-んァ-ン一-龥]+\z/.freeze
  KANA_REGEX = /\A[ァ-ヶー－]+\z/.freeze

  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください'

  with_options presence: true do
    validates :nickname
    validates :last_name, format: { with: ZENKAKU_REGEX, message: 'is invalid. Input full-width characters.' }
    validates :first_name, format: { with: ZENKAKU_REGEX, message: 'is invalid. Input full-width characters.' }
    validates :last_name_kana, format: { with: KANA_REGEX, message: 'is invalid. Input full-width katakana characters.' }
    validates :first_name_kana, format: { with: KANA_REGEX, message: 'is invalid. Input full-width katakana characters.' }
    validates :birthday
  end
end
