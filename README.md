# README

# テーブル設計

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| last_name          | string  | null: false               |
| first_name         | string  | null: false               |
| last_name_kana     | string  | null: false               |
| first_name_kana    | string  | null: false               |
| birth_year         | integer | null: false               |
| birth_month        | integer | null: false               |
| birth_date         | integer | null: false               |

### Association

has_many :items
has_many :orders


## items テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| name          | string     | null: false                    |
| detail        | string     | null: false                    |
| category      | string     | null: false                    |
| status        | string     | null: false                    |
| delivery_fee  | string     | null: false                    |
| area          | string     | null: false                    |
| delivery_days | string     | null: false                    |
| price         | integer    | null: false                    |
| user_id       | references | null: false, foreign_key: true |

### Association

belongs_to :user
has_one :order


## orders テーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| item_id    | references | null: false, foreign_key: true |
| address_id | references | null: false, foreign_key: true |
| user_id    | references | null: false, foreign_key: true |

### Association

belongs_to :item
has_one :address


## addresses テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| post_code    | string     | null: false                    |
| prefecture   | string     | null: false                    |
| town         | references | null: false, foreign_key: true |
| house_number | references | null: false                    |
| building     | string     |                                |
| phone_number | integer    | null: false                    |
| item_id      | references | null: false, foreign_key: true |

### Association

belongs_to :oder