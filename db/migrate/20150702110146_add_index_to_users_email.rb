class AddIndexToUsersEmail < ActiveRecord::Migration
  def change #add index makes it easy to find a user and do not need to scan the email one by one.
    add_index :users, :email, unique: true
  end
end
