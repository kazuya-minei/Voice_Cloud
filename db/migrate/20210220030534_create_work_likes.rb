class CreateWorkLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :work_likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :work, null: false, foreign_key: true

      t.timestamps
    end
  end
end
