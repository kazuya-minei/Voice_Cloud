class CreateVoiceLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :voice_likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :voice, null: false, foreign_key: true

      t.timestamps
    end
  end
end
