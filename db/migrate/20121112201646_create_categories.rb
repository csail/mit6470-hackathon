class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, null: false, limit: 32
    end
    add_index :categories, :name, null: false, unique: true
  end
end
