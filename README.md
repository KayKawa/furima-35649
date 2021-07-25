# テーブル設計

## users テーブル

| Column             | Type   | Options                    |
| ------------------ | ------ | -------------------------- |
| nickname           | string | null: false                |
| email              | string | null: false , unique: true |
| encrypted_password | string | null: false                |
| last_name          | string | null: false                |
| first_name         | string | null: false                |
| last_name_kana     | string | null: false                |
| first_name_kana    | string | null: false                |
| birthday           | date   | null: false                |

### Association

- has_many:items
- has_many:purchases

## items テーブル

| Column        | Type       | Options          |
| ------------- | ---------- | ---------------- |
| user          | references | foreign_key:true |
| name          | string     | null: false      |
| content       | text       | null: false      |
| category_id   | integer    | null: false      |
| condition_id  | integer    | null: false      |
| cost_id       | integer    | null: false      |
| prefecture_id | integer    | null: false      |
| schedule_id   | integer    | null: false      |
| price         | integer    | null: false      |

### Association

- belongs_to:user
- has_one:purchase
- belongs_to :seller, class_name: "User"
- belongs_to :buyer, class_name: "User"

## purchases テーブル

| Column | Type       | Options          |
| ------ | ---------- | ---------------- |
| user   | references | foreign_key:true |
| item   | references | foreign_key:true |

### Association

- belongs_to:item
- belongs_to:user
- has_one:shipping_address

## shipping_address テーブル

| Column        | Type       | Options          |
| ------------- | ---------- | ---------------- |
| purchase      | references | foreign_key:true |
| postcode      | string     | null: false      |
| prefecture_id | integer    | null: false      |
| city          | string     | null: false      |
| address       | string     | null: false      |
| building_name | string     |                  |
| phone_number  | string     | null: false      |

### Association

- belongs_to:purchase
