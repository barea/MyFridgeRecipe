class AddChefToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :chef, :boolean, default: false
  end
end
