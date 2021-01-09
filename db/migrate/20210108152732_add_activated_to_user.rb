class AddActivatedToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :activated, :boolean, null: false, default: false
  end
end
