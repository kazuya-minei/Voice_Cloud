class CreateVoices < ActiveRecord::Migration[6.1]
  def change
    create_table :voices do |t|
      t.references :user, null: false, foreign_key: true
      t.references :work, null: false, foreign_key: true
      t.string :voice_data

      t.timestamps
    end
    add_index :voices, [:user_id, :created_at]
    add_index :voices, [:work_id, :created_at]
  end
end
