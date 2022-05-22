class CreateTwbooks < ActiveRecord::Migration[6.0]
  def change
    create_table :twbooks do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :twbooks, [:user_id, :created_at]
  end
end
