class AddActivationTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :activation_token, :integer
  end
end
