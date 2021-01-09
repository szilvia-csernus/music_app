class ChangeActivationTokenForUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :activation_token, :string
  end
end
