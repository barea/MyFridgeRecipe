class RenameChefIdToUserId < ActiveRecord::Migration[6.0]
  def change
  	rename_column :recipes, :chef_id, :user_id
  end
end
