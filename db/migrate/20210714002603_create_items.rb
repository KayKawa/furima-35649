class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.references :user, foreign_key: true
      t.string :name, null: false
      t.text :content, null: false
      t.integer :category_id, null: false
      t.integer :condition_id, null: false
      t.integer :cost_id, null: false
      t.integer :prefecture_id, null: false
      t.integer :schedule_id, null: false
      t.integer :price, null: false
      t.integer :seller_id, foreign_key: 'user_id'
      t.integer :buyer_id, foreign_key: 'user_id'
      t.timestamps
    end
  end
end
