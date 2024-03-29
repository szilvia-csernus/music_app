class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.integer :user_id
      t.references :tagging, polymorphic: true
      t.timestamps
    end
    add_index :tags, [:user_id, :tagging_id, :tagging_type], unique: true
  end

end
