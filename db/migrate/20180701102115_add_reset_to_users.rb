class AddResetToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :reset_digest, :stirng
    add_column :users, :reset_sent_at, :datetime
  end
end
