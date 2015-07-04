class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :content
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    
    add_foreign_key :posts, :users
#The foreign key reference is a database-level constraint indicating that the user id in the microposts table
#refers to the id column in the users table.
    add_index :posts, [:user_id, :created_at]
# By including both the user_id and created_at columns as an array, we
# arrange for Rails to create a multiple key index, which means that Active Record
# uses both keys at the same time.
  end
end
