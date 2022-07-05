class AddManagerIdIndexToUsers < ActiveRecord::Migration[7.0]
  def change
    add_index :users, :manager_id
  end
end
