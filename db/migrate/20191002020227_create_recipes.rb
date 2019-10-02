class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :prep
      t.string :preptime
      t.integer :serving
      t.integer :chef_id

      t.timestamps
    end
  end
end
