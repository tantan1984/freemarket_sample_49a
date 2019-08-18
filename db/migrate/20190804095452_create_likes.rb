class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :user_id,    null:false
      t.integer :product_id, null:false
      t.integer :like,       null:false
      t.integer :bad,        null:false
    end
  end 
end
