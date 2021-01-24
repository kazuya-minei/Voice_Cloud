class AddVoicesampleToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :voice_s, :string
  end
end
