class RemoveFromUsers < ActiveRecord::Migration[6.1]
  def up 
    remove_column :users, :password_digest
    remove_column :users, :remember_digest
  end

  def down
    add_colum :users, :password_digest, :string
    add_colum :users, :remember_digest, :string
  end

end
