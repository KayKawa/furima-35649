# テーブル設計

## users テーブル

| Column          | Type   | Options                    |
| --------------- | ------ | -------------------------- |
| nickname        | string | null: false                |
| email           | string | null: false , unique: true |
| password        | string | null: false                |
| last_name       | string | null: false                |
| first_name      | string | null: false                |
| last_name_kana  | string | null: false                |
| first_name_kana | string | null: false                |
| birthday        | day    | null: false                |

### Association

- has_many:items
- has_many:purchases

## items テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| user          | references | null: false , foreign_key:true |
| item_name     | string     | null: false                    |
| item_content  | text       | null: false                    |
| category      | integer    | null: false                    |
| condition     | integer    | null: false                    |
| cost          | integer    | null: false                    |
| shipping_area | integer    | null: false                    |
| shipping_day  | integer    | null: false                    |
| price         | integer    | null: false                    |

### Association

- belongs_to:user
- has_one:purchase

## purchases テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false , foreign_key:true |
| item   | references | null: false , foreign_key:true |

### Association

- belongs_to:item
- belongs_to:user
- has_one:shipping_address

## shipping_address テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| purchase      | references | null: false , foreign_key:true |
| postcode      | string     | null: false                    |
| prefectures   | integer    | null: false                    |
| city          | string     | null: false                    |
| address       | string     | null: false                    |
| building_name | string     |                                |
| phone_number  | string     | null: false                    |

### Association

- belongs_to:purchase
