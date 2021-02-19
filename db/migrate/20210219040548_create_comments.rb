class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :voice, null: false, foreign_key: true
      t.text :comment

      t.timestamps
    end
    add_index :comments, [:voice_id, :created_at]
  end
end
